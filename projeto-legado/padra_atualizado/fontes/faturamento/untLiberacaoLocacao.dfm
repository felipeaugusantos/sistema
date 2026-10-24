inherited frmLiberacaoLocacao: TfrmLiberacaoLocacao
  Width = 866
  Height = 557
  Caption = 
    'Libera'#231#227'o de Equipamentos para nova Loca'#231#227'o ap'#243's Inspe'#231#227'o de Ent' +
    'rada'
  OnDestroy = FormDestroy
  ExplicitWidth = 866
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 484
    Width = 860
    ExplicitTop = 484
    ExplicitWidth = 860
    inherited FlwBotoes: TFlowPanel
      Width = 856
      ExplicitWidth = 856
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
      object btnMarcarTodos: TBitBtnLocked
        Left = 111
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F3] Marcar todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F4] Desmarcar todos '
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnMarcarAcessEquip: TBitBtnLocked
        Left = 351
        Top = 0
        Width = 138
        Height = 22
        Caption = '[F5] Marcar Equipamento'
        TabOrder = 3
        OnClick = btnMarcarAcessEquipClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 780
      ExplicitLeft = 780
    end
  end
  inherited pnlStatus: TPanel
    Top = 512
    Width = 860
    ExplicitTop = 512
    ExplicitWidth = 860
    inherited pnlNomeForm: TPanel
      Left = 689
      ExplicitLeft = 689
    end
    inherited pnlInfo: TPanel
      Width = 689
      ExplicitWidth = 689
      object btnShowTrace: TSpeedButton
        Left = 687
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 687
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [2]
    Left = 0
    Top = 484
    Width = 860
    Height = 0
    TabOrder = 2
    object lblNSQLTrace: TLabel
      Left = 797
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 860
    Height = 61
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 3
    object lblNumCon: TLabel
      Left = 228
      Top = 9
      Width = 99
      Height = 14
      Caption = 'N'#250'mero do Contrato:'
    end
    object lblTroca: TLabel
      Left = 22
      Top = 33
      Width = 86
      Height = 14
      Caption = 'N'#250'mero da Troca:'
    end
    object lblNumPed: TLabel
      Left = 73
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Pedido:'
    end
    object edtNumCon: TEditFocus
      Tag = 99
      Left = 330
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
    Top = 61
    Width = 860
    Height = 79
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
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
    object edtLocalizacao: TEditFocus
      Tag = 99
      Left = 78
      Top = 54
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
      Top = 6
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
      Top = 30
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
      Top = 30
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
  object pnlItensContrato: TPanel [5]
    Left = 0
    Top = 140
    Width = 860
    Height = 344
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 5
    object grpEquipamentos: TGroupBox
      Left = 0
      Top = 0
      Width = 860
      Height = 149
      Align = alClient
      Caption = '   Equipamentos do Contrato'
      TabOrder = 0
      object cxgrdItens: TcxGridCitel
        Left = 2
        Top = 16
        Width = 856
        Height = 131
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgrdItensView: TcxGridDBTableViewCitel
          OnKeyDown = cxgrdItensViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgrdItensViewCustomDrawCell
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
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgrdItensViewEQD_SEQEQL: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQD_SEQEQL'
            Options.Editing = False
            Width = 76
          end
          object cxgrdItensViewEQL_DESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'EQL_DESCRI'
            Options.Editing = False
            Width = 267
          end
          object cxgrdItensViewEQL_NSERIE: TcxGridDBColumn
            Caption = 'N'#250'mero de S'#233'rie'
            DataBinding.FieldName = 'EQL_NSERIE'
            Options.Editing = False
            Width = 90
          end
          object cxgrdItensViewEQD_QTDEQU: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'EQD_QTDEQU'
          end
          object cxgrdItensViewEQD_DTAIPE: TcxGridDBColumn
            Caption = 'Inspe'#231#227'o de Entrada'
            DataBinding.FieldName = 'EQD_DTAIPE'
            Options.Editing = False
            VisibleForCustomization = False
            VisibleForEditForm = bFalse
          end
          object cxgrdItensViewEQD_AVARIA: TcxGridDBColumn
            Caption = 'Avaria?'
            DataBinding.FieldName = 'EQD_AVARIA'
            Options.Editing = False
            Width = 45
          end
          object cxgrdItensViewEQD_OBSIPE: TcxGridDBColumn
            Caption = 'Observa'#231#245'es'
            DataBinding.FieldName = 'EQD_OBSIPE'
            Options.Editing = False
            Width = 320
          end
          object cxgrdItensViewEQD_CONFER: TcxGridDBColumn
            Caption = 'Conferente'
            DataBinding.FieldName = 'EQD_CONFER'
            Options.Editing = False
            Width = 180
          end
          object cxgrdItensViewEQD_SUPERV: TcxGridDBColumn
            Caption = 'Supervisor'
            DataBinding.FieldName = 'EQD_SUPERV'
            Options.Editing = False
            Width = 180
          end
          object cxgrdItensViewEQD_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'EQD_MARDES'
            Visible = False
          end
        end
        object cxgrdItensLvl: TcxGridLevel
          GridView = cxgrdItensView
        end
      end
    end
    object grpAcessorios: TGroupBox
      Left = 0
      Top = 149
      Width = 860
      Height = 195
      Align = alBottom
      Caption = '   Acess'#243'rios do Contrato'
      TabOrder = 1
      object cxGridAcessorios: TcxGridCitel
        Left = 2
        Top = 16
        Width = 856
        Height = 177
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel
          OnKeyDown = cxGridDBTableViewAcessoriosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGridDBTableViewAcessoriosCustomDrawCell
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
            Width = 90
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
          end
        end
        object cxGridAcessoriosLeve1: TcxGridLevel
          GridView = cxGridDBTableViewAcessorios
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 736
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 808
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 656
    Top = 56
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
        Name = 'EQA_QTDTOT'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'cdsAcessoriosIndex1'
      end>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 186
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
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPE'
      Size = 100
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
    object cdsAcessoriosEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsAcessoriosEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsAcessoriosEQD_CONFER: TStringField
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object cdsAcessoriosEQD_SUPERV: TStringField
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object cdsAcessoriosEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsAcessoriosEQD_DESCRI: TStringField
      DisplayWidth = 100
      FieldName = 'EQD_DESCRI'
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
        Name = 'EQD_QTDEQU'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 166
    Top = 238
    object cdsEqlDetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
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
    object cdsEqlDetEQD_DTAIPE: TDateTimeField
      FieldName = 'EQD_DTAIPE'
    end
    object cdsEqlDetEQD_AVARIA: TStringField
      FieldName = 'EQD_AVARIA'
    end
    object cdsEqlDetEQD_OBSIPE: TMemoField
      DisplayWidth = 100
      FieldName = 'EQD_OBSIPE'
      BlobType = ftMemo
    end
    object cdsEqlDetEQD_SUPERV: TStringField
      FieldName = 'EQD_SUPERV'
      Size = 70
    end
    object cdsEqlDetEQD_CONFER: TStringField
      FieldName = 'EQD_CONFER'
      Size = 70
    end
    object cdsEqlDetEQD_MARDES: TStringField
      FieldName = 'EQD_MARDES'
    end
    object cdsEqlDetEQA_MARDES: TStringField
      FieldName = 'EQA_MARDES'
    end
    object cdsEqlDetEQD_QTDEQU: TFloatField
      FieldName = 'EQD_QTDEQU'
    end
  end
  object dtsEqlDet: TDataSource
    DataSet = cdsEqlDet
    Left = 281
    Top = 239
  end
  object dtsAcessorios: TDataSource
    DataSet = cdsAcessorios
    Left = 280
    Top = 186
  end
end
