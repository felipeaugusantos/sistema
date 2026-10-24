object frmReformaConvert: TfrmReformaConvert
  Left = 0
  Top = 0
  ActiveControl = cxgEmpresas
  Caption = 'Ativar Pre'#231'os Reforma Tribut'#225'ria'
  ClientHeight = 550
  ClientWidth = 890
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object splEmpresas: TSplitter
    Left = 0
    Top = 356
    Width = 890
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 363
    ExplicitWidth = 900
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 890
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object lblAviso: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 878
      Height = 26
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Align = alTop
      AutoSize = False
      Caption = 
        'Converte custo e pre'#231'o de TODOS os produtos da empresa logada e ' +
        'das empresas que usam o pre'#231'o dela: aplica o desconto PIS/COFINS' +
        ' (REFPRE), a despesa operacional da REFPRE, zera os impostos fed' +
        'erais e recalcula pre'#231'o de venda ou margem. Ao final liga a CFG_' +
        'REFCIS (soma CBS/IBS/IS no valor cont'#225'bil da nota).'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 888
    end
    object lblSituacao: TLabel
      AlignWithMargins = True
      Left = 6
      Top = 35
      Width = 878
      Height = 16
      Margins.Left = 6
      Margins.Right = 6
      Align = alTop
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 38
      ExplicitWidth = 888
    end
  end
  object pnlOpcoes: TPanel
    Left = 0
    Top = 62
    Width = 890
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object rdgOrigemImpostos: TRadioGroup
      AlignWithMargins = True
      Left = 197
      Top = 3
      Width = 204
      Height = 48
      Margins.Left = 6
      Align = alLeft
      Caption = ' Origem dos Impostos (CBS/IBS/IS) '
      ItemIndex = 0
      Items.Strings = (
        'Tabela Est'#225'tica'
        'Abrevia'#231#227'o do Item')
      TabOrder = 0
    end
    object rdgSomenteAtivos: TRadioGroup
      AlignWithMargins = True
      Left = 407
      Top = 3
      Width = 154
      Height = 48
      Margins.Right = 6
      Align = alLeft
      Caption = ' Somente Itens Ativos '
      ItemIndex = 0
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 1
    end
    object rdgOpcao: TRadioGroup
      AlignWithMargins = True
      Left = 6
      Top = 3
      Width = 179
      Height = 48
      Margins.Left = 6
      Margins.Right = 6
      Align = alLeft
      Caption = ' Op'#231#227'o de rec'#225'lculo '
      Items.Strings = (
        'Recalcular Pre'#231'o de Venda'
        'Recalcular Margem')
      TabOrder = 2
    end
  end
  object cxgDivergencias: TcxGrid
    AlignWithMargins = True
    Left = 6
    Top = 364
    Width = 878
    Height = 155
    Margins.Left = 6
    Margins.Right = 6
    Align = alBottom
    TabOrder = 1
    object tbvDivergencias: TcxGridDBTableView
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
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object colDivEmpresa: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'DIV_CODEMP'
        Width = 60
      end
      object colDivTipo: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'DIV_TIPO'
        Width = 90
      end
      object colDivItem: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'DIV_CODITE'
        Width = 70
      end
      object colDivCampo: TcxGridDBColumn
        Caption = 'Campo'
        DataBinding.FieldName = 'DIV_CAMPO'
        Width = 120
      end
      object colDivEsperado: TcxGridDBColumn
        Caption = 'Esperado'
        DataBinding.FieldName = 'DIV_ESPERA'
        Width = 220
      end
      object colDivEncontrado: TcxGridDBColumn
        Caption = 'Encontrado'
        DataBinding.FieldName = 'DIV_ENCONT'
        Width = 220
      end
    end
    object lvlDivergencias: TcxGridLevel
      GridView = tbvDivergencias
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 522
    Width = 890
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      890
      28)
    object FlwBotoes: TFlowPanel
      Left = 2
      Top = 2
      Width = 886
      Height = 24
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 85
        Height = 22
        Caption = '&Confirma'
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
      object btnConferir: TBitBtnLocked
        Left = 85
        Top = 0
        Width = 85
        Height = 22
        Caption = 'Con&ferir'
        TabOrder = 1
        OnClick = btnConferirClick
      end
      object btnReverter: TBitBtnLocked
        Left = 170
        Top = 0
        Width = 85
        Height = 22
        Caption = '&Reverter'
        TabOrder = 2
        OnClick = btnReverterClick
      end
    end
    object btnSair: TBitBtnLocked
      Left = 810
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'C&ancela'
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
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlGrupos: TPanel
    Left = 0
    Top = 116
    Width = 890
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    object cxgEmpresas: TcxGrid
      AlignWithMargins = True
      Left = 6
      Top = 3
      Width = 878
      Height = 212
      Margins.Left = 6
      Margins.Right = 6
      Align = alClient
      TabOrder = 0
      object tbvEmpresas: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.KeyFieldNames = 'EMP_CODEMP'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        object colEmpSelecao: TcxGridDBColumn
          Caption = 'Sel.'
          DataBinding.FieldName = 'SEL'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.NullStyle = nssUnchecked
          HeaderAlignmentHorz = taCenter
          Width = 35
        end
        object colEmpCodigo: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMP_CODEMP'
          Width = 55
        end
        object colEmpPreco: TcxGridDBColumn
          Caption = 'Empresas do Pre'#231'o'
          DataBinding.FieldName = 'EMPRESAS_PRECO'
          Width = 150
        end
        object colEmpNome: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'EMP_NOMEMP'
          Width = 180
        end
        object colEmpConvertida: TcxGridDBColumn
          Caption = 'Convertida'
          DataBinding.FieldName = 'CONVERTIDA'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object colEmpSituacao: TcxGridDBColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'SITUACAO'
          Width = 110
        end
        object colEmpInicio: TcxGridDBColumn
          Caption = 'In'#237'cio'
          DataBinding.FieldName = 'INICIO'
          Width = 115
        end
        object colEmpFim: TcxGridDBColumn
          Caption = 'Fim'
          DataBinding.FieldName = 'FIM'
          Width = 115
        end
        object colEmpOperador: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'OPERADOR'
          Width = 65
        end
        object colEmpOpcao: TcxGridDBColumn
          Caption = 'Op'#231#227'o'
          DataBinding.FieldName = 'OPCAO'
          Width = 95
        end
        object colEmpItens: TcxGridDBColumn
          Caption = 'Itens'
          DataBinding.FieldName = 'ITENS'
          Width = 55
        end
        object colEmpAplicados: TcxGridDBColumn
          Caption = 'Aplicados'
          DataBinding.FieldName = 'APLICADOS'
          Width = 60
        end
        object colEmpDivergencias: TcxGridDBColumn
          Caption = 'Diverg'#234'ncias'
          DataBinding.FieldName = 'DIVERGENCIAS'
          Width = 75
        end
        object colEmpObservacao: TcxGridDBColumn
          Caption = 'Observa'#231#227'o'
          DataBinding.FieldName = 'OBSERVACAO'
          Width = 300
        end
        object colEmpOrdem: TcxGridDBColumn
          DataBinding.FieldName = 'ORDEM'
          Visible = False
          VisibleForCustomization = False
        end
        object colEmpPode: TcxGridDBColumn
          DataBinding.FieldName = 'PODE'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object tbvEmpresasGrupo: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DetailKeyFieldNames = 'GRUPO'
        DataController.KeyFieldNames = 'GRUPO;EMP_CODEMP'
        DataController.MasterKeyFieldNames = 'EMP_CODEMP'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        object colGruCodigo: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMP_CODEMP'
          Width = 55
        end
        object colGruNome: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'EMP_NOMEMP'
          Width = 200
        end
        object colGruOrigem: TcxGridDBColumn
          Caption = 'Origem'
          DataBinding.FieldName = 'ORIGEM'
          Width = 110
        end
        object colGruConvertida: TcxGridDBColumn
          Caption = 'Convertida'
          DataBinding.FieldName = 'CONVERTIDA'
          HeaderAlignmentHorz = taCenter
          Width = 70
        end
        object colGruSituacao: TcxGridDBColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'SITUACAO'
          Visible = False
          VisibleForCustomization = False
          Width = 130
        end
      end
      object lvlEmpresas: TcxGridLevel
        GridView = tbvEmpresas
        object lvlEmpresasGrupo: TcxGridLevel
          GridView = tbvEmpresasGrupo
        end
      end
    end
    object pnlMarcar: TPanel
      Left = 0
      Top = 218
      Width = 890
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      Padding.Left = 8
      TabOrder = 1
      object btnMarcarTodos: TBitBtnLocked
        Left = 8
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '&Marcar Todos'
        TabOrder = 0
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 108
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '&Desmarcar Todos'
        TabOrder = 1
        OnClick = btnDesmarcarTodosClick
      end
    end
  end
  object dtsEmpresas: TDataSource
    Left = 560
    Top = 184
  end
  object dtsEmpresasGrupo: TDataSource
    Left = 640
    Top = 184
  end
  object dtsDivergencias: TDataSource
    Left = 560
    Top = 432
  end
end
