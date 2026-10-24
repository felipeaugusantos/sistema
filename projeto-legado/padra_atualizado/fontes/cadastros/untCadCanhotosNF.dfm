inherited frmCadCanhotosNF: TfrmCadCanhotosNF
  Width = 1060
  Height = 590
  BorderIcons = [biSystemMenu]
  Caption = 'Controle de Canhotos de Notas Fiscais Emitidas'
  Position = poMainFormCenter
  ExplicitWidth = 1060
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 517
    Width = 1054
    ExplicitTop = 517
    ExplicitWidth = 1054
    inherited FlwBotoes: TFlowPanel
      Width = 1050
      TabOrder = 5
      ExplicitWidth = 1050
    end
    inherited btnSair: TBitBtnLocked
      Left = 971
      TabOrder = 4
      ExplicitLeft = 971
    end
    object btnSelTodos: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 120
      Height = 22
      Caption = '[ F4 ] Selecionar Todos'
      TabOrder = 0
      OnClick = btnSelTodosClick
    end
    object btnRecebidos: TBitBtnLocked
      Left = 129
      Top = 3
      Width = 170
      Height = 22
      Caption = '[ F5 ] Atualizar para Recebidos'
      TabOrder = 1
      OnClick = btnRecebidosClick
    end
    object btnAtualizarFiltro: TBitBtnLocked
      Left = 474
      Top = 3
      Width = 120
      Height = 22
      Caption = '[ F7 ] Atualizar Filtro'
      TabOrder = 3
      OnClick = btnAtualizarFiltroClick
    end
    object btnPendentes: TBitBtnLocked
      Left = 301
      Top = 3
      Width = 170
      Height = 22
      Caption = '[ F6 ] Atualizar para Pendentes'
      TabOrder = 2
      OnClick = btnPendentesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1054
    ExplicitTop = 545
    ExplicitWidth = 1054
    inherited pnlNomeForm: TPanel
      Left = 883
      ExplicitLeft = 883
    end
    inherited pnlInfo: TPanel
      Width = 883
      ExplicitWidth = 883
    end
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 1054
    Height = 517
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grpFiltros: TGroupBox
      Left = 0
      Top = 0
      Width = 1054
      Height = 145
      Align = alTop
      Caption = '   Filtros   '
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      object pnlFiltrosControleCanhoto: TPanel
        Left = 457
        Top = 16
        Width = 352
        Height = 127
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'pnlFiltrosControleCanhoto'
        ShowCaption = False
        TabOrder = 1
        object pnlDataCanhoto: TPanel
          Left = 0
          Top = 0
          Width = 352
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlDataCanhoto'
          ShowCaption = False
          TabOrder = 0
          ExplicitWidth = 344
          object Label1: TLabel
            Left = 16
            Top = 5
            Width = 71
            Height = 14
            Caption = 'Data Canhoto: '
          end
          object Label5: TLabel
            Left = 160
            Top = 5
            Width = 6
            Height = 12
            Alignment = taRightJustify
            AutoSize = False
            Caption = #224
          end
          object mskDtcIni: TMaskEditFocus
            Tag = 99
            Left = 87
            Top = 0
            Width = 69
            Height = 22
            EditMask = '99/99/9999'
            ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
          object mskDtcFin: TMaskEditFocus
            Tag = 99
            Left = 170
            Top = 0
            Width = 69
            Height = 22
            EditMask = '99/99/9999'
            ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 1
            Text = '  /  /    '
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = True
          end
        end
        object pnlNomeCanhoto: TPanel
          Left = 0
          Top = 24
          Width = 352
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlNomeCanhoto'
          ShowCaption = False
          TabOrder = 1
          ExplicitWidth = 344
          object Label6: TLabel
            Left = 10
            Top = 6
            Width = 75
            Height = 14
            Caption = 'Nome canhoto: '
          end
          object edtNomCht: TEditFocus
            Tag = 99
            Left = 88
            Top = 2
            Width = 250
            Height = 22
            Alignment = taLeftJustify
            ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
            MaxLength = 60
            TabOrder = 0
            OnKeyPress = edtCodEmpKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 60
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object pnlFiltrosGerais: TPanel
        Left = 2
        Top = 16
        Width = 455
        Height = 127
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'pnlFiltrosGerais'
        ShowCaption = False
        TabOrder = 0
        object Label4: TLabel
          Left = 9
          Top = 31
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object Label2: TLabel
          Left = 15
          Top = 5
          Width = 39
          Height = 14
          Alignment = taRightJustify
          Caption = 'Per'#237'odo:'
        end
        object Label3: TLabel
          Left = 132
          Top = 5
          Width = 6
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = #224
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 59
          Top = 25
          Width = 62
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 123
          Top = 25
          Width = 319
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
        object mskDtaIni: TMaskEditFocus
          Tag = 99
          Left = 59
          Top = 1
          Width = 70
          Height = 22
          EditMask = '99/99/9999'
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object mskDtaFin: TMaskEditFocus
          Tag = 99
          Left = 142
          Top = 1
          Width = 69
          Height = 22
          EditMask = '99/99/9999'
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 1
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = True
        end
        object rgdTipo: TRadioGroup
          Tag = 99
          Left = 59
          Top = 50
          Width = 383
          Height = 35
          Caption = '   Tipo de Movimento   '
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Entrada'
            'Sa'#237'da'
            'Todos')
          TabOrder = 4
        end
        object rgdCanhotos: TRadioGroup
          Tag = 99
          Left = 59
          Top = 85
          Width = 383
          Height = 35
          Caption = '   Canhotos   '
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            'Pendente'
            'Recebido'
            'Todos')
          TabOrder = 5
          OnExit = rgdCanhotosExit
        end
      end
    end
    object grpCanhotos: TGroupBox
      Left = 0
      Top = 145
      Width = 1054
      Height = 372
      Align = alClient
      Caption = '   Movimenta'#231#227'o de Canhotos de Notas Fiscais   '
      TabOrder = 1
      object cxgrdCanhotosNFs: TcxGrid
        Left = 2
        Top = 16
        Width = 1050
        Height = 354
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdCanhotosNFs: TcxGridDBTableView
          OnKeyDown = grdCanhotosNFsKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = grdCanhotosNFsCellDblClick
          OnCustomDrawCell = grdCanhotosNFsCustomDrawCell
          DataController.DataSource = dtsCanhotos
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object clmCanhotosNFsStatus: TcxGridDBColumn
            Caption = 'Situa'#231#227'o'
            DataBinding.FieldName = 'CNHREC'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 75
          end
          object clmCanhotosNFsData: TcxGridDBColumn
            Caption = 'Data Emiss'#227'o'
            DataBinding.FieldName = 'DTAENT'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 80
          end
          object clmCanhotosNFsHora: TcxGridDBColumn
            Caption = 'Hora Emiss'#227'o'
            DataBinding.FieldName = 'HOREMI'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 80
          end
          object clmCanhotosNFsDocumento: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'NUMDOC'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 110
          end
          object clmCanhotosNFsEntSai: TcxGridDBColumn
            Caption = 'E/S'
            DataBinding.FieldName = 'ENTSAI'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 30
          end
          object clmCanhotosNFsSerie: TcxGridDBColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'SERIE_'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 35
          end
          object clmCanhotosNFsVendedor: TcxGridDBColumn
            Caption = 'Vendedor'
            DataBinding.FieldName = 'VENDEDOR'
            Width = 150
          end
          object clmCanhotosNFsForCli: TcxGridDBColumn
            Caption = 'F/C'
            DataBinding.FieldName = 'TIP_FC'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Width = 30
          end
          object clmCanhotosNFsDesForCli: TcxGridDBColumn
            Caption = 'Fornecedor/Cliente'
            DataBinding.FieldName = 'FORCLI'
            Width = 230
          end
          object clmCanhotosNfsDtaCht: TcxGridDBColumn
            Caption = 'Data Canhoto'
            DataBinding.FieldName = 'DTACHT'
            Options.Editing = False
            Width = 80
          end
          object clmCanhotosNFsNomCht: TcxGridDBColumn
            Caption = 'Nome Canhoto'
            DataBinding.FieldName = 'NOMCHT'
            Options.Editing = False
            Width = 170
          end
          object clmCanhotosNFsAutoincrem: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
          end
          object clmCanhotosNFsMarDes: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
          end
        end
        object glvCanhotosNFs: TcxGridLevel
          GridView = grdCanhotosNFs
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 720
    Top = 376
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 720
    Top = 344
  end
  object dtsCanhotos: TDataSource
    Left = 552
    Top = 304
  end
end
