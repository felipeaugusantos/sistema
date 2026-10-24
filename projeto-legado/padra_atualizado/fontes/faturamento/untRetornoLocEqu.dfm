inherited frmRetornoLocEqu: TfrmRetornoLocEqu
  Width = 850
  Height = 550
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'Retorno de equipamentos de loca'#231#227'o'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 850
  ExplicitHeight = 550
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 477
    Width = 844
    TabOrder = 3
    ExplicitTop = 477
    ExplicitWidth = 844
    inherited FlwBotoes: TFlowPanel
      Width = 840
      ExplicitWidth = 840
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F10] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F3] Marcar todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 240
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F4] Desmarcar todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 763
      Top = 2
      ExplicitLeft = 763
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 505
    Width = 844
    TabOrder = 4
    ExplicitTop = 505
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
    Left = 6
    Top = 479
    Width = 844
    Height = 0
    TabOrder = 5
    Visible = False
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
      Left = 249
      Top = 8
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblNumPed: TLabel
      Left = 35
      Top = 10
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 354
      Top = 5
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
      Left = 76
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
    Top = 34
    Width = 844
    Height = 161
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
      Left = 504
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
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtLocalizacao: TDBEditFocus
      Tag = 99
      Left = 78
      Top = 54
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
    object grbDuracao: TGroupBox
      Left = 78
      Top = 78
      Width = 395
      Height = 77
      Caption = '   Dura'#231#227'o do Contrato   '
      TabOrder = 6
      object pnlDuracaoDiariaHoras: TPanel
        Left = 2
        Top = 16
        Width = 391
        Height = 27
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblInicio: TLabel
          Left = 31
          Top = 10
          Width = 27
          Height = 14
          Caption = 'In'#237'cio:'
        end
        object lblTermino: TLabel
          Left = 183
          Top = 10
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
        Width = 391
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
  end
  object grpDetalhes: TGroupBox [5]
    Left = 0
    Top = 195
    Width = 844
    Height = 282
    Align = alClient
    Caption = '   Equipamentos do Contrato   '
    TabOrder = 2
    object grpAcessorios: TGroupBox
      Left = 2
      Top = 123
      Width = 840
      Height = 157
      Align = alBottom
      Caption = 'Acess'#243'rios do Contrato'
      TabOrder = 0
      object cxGridCitelAcessorio: TcxGridCitel
        Left = 2
        Top = 16
        Width = 836
        Height = 139
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitelAcessorio: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGridDBTableViewCitelAcessorioCustomDrawCell
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
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBColumnEQD_SEQACL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQACL'
            Width = 92
          end
          object cxGridDBColumnEQD_DESCR: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQD_DESCRI'
            Width = 323
          end
          object cxGridDBColumnEQD_QTDACL: TcxGridDBColumn
            Caption = 'Qtd. Por Equipamento'
            DataBinding.FieldName = 'EQD_QTDACL'
            Width = 111
          end
          object cxGridDBColumnEQA_QTDTOT: TcxGridDBColumn
            Caption = 'Qtde.Total'
            DataBinding.FieldName = 'EQA_QTDTOT'
          end
          object cxGridDBColumnEQD_STTIPS: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Entrada'
            DataBinding.FieldName = 'EQD_STTIPE'
            Width = 137
          end
          object cxGridDBColumnEQD_DOCENV: TcxGridDBColumn
            Caption = 'Documento de retorno'
            DataBinding.FieldName = 'EQD_DOCRET'
            Width = 139
          end
          object cxGridDBColumnEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
          end
        end
        object cxGridLevel1Acessorio: TcxGridLevel
          GridView = cxGridDBTableViewCitelAcessorio
        end
      end
    end
    object pnlEquipamentos: TPanel
      Left = 2
      Top = 16
      Width = 840
      Height = 107
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object grdItens: TcxGridCitel
        Left = 0
        Top = 0
        Width = 840
        Height = 87
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdItensView: TcxGridDBTableViewCitel
          OnKeyDown = grdItensViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdItensViewCustomDrawCell
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
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdItensEQL_CODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQEQL'
            Width = 92
          end
          object grdItensEQL_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQD_DESCRI'
            Width = 323
          end
          object grdItensEQL_NSERIE: TcxGridDBColumn
            Caption = 'N'#250'mero de S'#233'rie'
            DataBinding.FieldName = 'EQD_NSERIE'
            Width = 111
          end
          object grdItensEQD_QTDEQU: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'EQD_QTDEQU'
          end
          object grdItensEQD_STTIPE: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de entrada'
            DataBinding.FieldName = 'EQD_STTIPE'
            Width = 137
          end
          object grdItensEQD_DOCRET: TcxGridDBColumn
            Caption = 'Documento de retorno'
            DataBinding.FieldName = 'EQD_DOCRET'
            Width = 139
          end
          object grdItensEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
          end
        end
        object grdItensLvl: TcxGridLevel
          GridView = grdItensView
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 87
        Width = 840
        Height = 20
        Align = alBottom
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '   Pressione [ENTER] para marcar ou desmarcar um equipamento'
        TabOrder = 1
      end
    end
  end
  object dtsContrato: TDataSource
    Left = 688
    Top = 58
  end
  object cdsAcessorios: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 387
    object StringField1: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object StringField2: TStringField
      FieldName = 'EQD_DESCRI'
    end
    object StringField6: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsAcessoriosEQD_QTDACL: TFloatField
      FieldName = 'EQD_QTDACL'
    end
    object cdsAcessoriosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsAcessoriosEQD_SEQACL: TStringField
      FieldName = 'EQD_SEQACL'
    end
    object cdsAcessoriosEQD_DOCRET: TStringField
      FieldName = 'EQD_DOCRET'
    end
    object cdsAcessoriosEQD_STTIPE: TStringField
      FieldName = 'EQD_STTIPE'
    end
    object cdsAcessoriosEQA_QTDTOT: TFloatField
      FieldName = 'EQA_QTDTOT'
    end
  end
  object dtsAcessorios: TDataSource
    DataSet = cdsAcessorios
    Left = 240
    Top = 386
  end
  object cdsEqlDet: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 227
    object cdsEqlDetEQD_SEQEQL: TStringField
      FieldName = 'EQD_SEQEQL'
    end
    object cdsEqlDetEQD_DESCRI: TStringField
      FieldName = 'EQD_DESCRI'
    end
    object cdsEqlDetEQD_NSERIE: TStringField
      FieldName = 'EQD_NSERIE'
    end
    object cdsEqlDetEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsEqlDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsEqlDetEQD_STTIPE: TStringField
      FieldName = 'EQD_STTIPE'
    end
    object cdsEqlDetEQD_DOCRET: TStringField
      FieldName = 'EQD_DOCRET'
    end
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 256
    Top = 226
  end
end
