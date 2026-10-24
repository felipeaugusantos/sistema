inherited frmOutrasInscricoesCadastraisPJ: TfrmOutrasInscricoesCadastraisPJ
  Width = 805
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Outras Inscri'#231#245'es Cadastrais da Pessoa Jur'#237'dica'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 805
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 523
    Width = 799
    Height = 32
    ExplicitTop = 523
    ExplicitWidth = 794
    ExplicitHeight = 32
    inherited FlwBotoes: TFlowPanel
      Width = 718
      Height = 28
      ExplicitTop = 2
      ExplicitWidth = 713
      ExplicitHeight = 28
    end
    inherited btnSair: TBitBtnLocked
      Left = 720
      Top = 2
      Height = 28
      Align = alRight
      ExplicitLeft = 715
      ExplicitTop = 2
      ExplicitHeight = 28
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 799
    ExplicitTop = 555
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 628
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 628
      ExplicitWidth = 623
    end
  end
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 0
    Width = 799
    Height = 523
    ActivePage = tbsDados
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    StyleElements = [seFont, seBorder]
    object tbsDados: TTabSheet
      Caption = 'Geral'
      ImageIndex = 1
      ExplicitWidth = 786
      object Label3: TLabel
        Left = 8
        Top = 3
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label4: TLabel
        Left = 389
        Top = 3
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Caption = 'Inscri'#231#227'o:'
      end
      object cxgDados: TcxGridCitel
        Left = 0
        Top = 51
        Width = 791
        Height = 440
        Align = alBottom
        TabOrder = 5
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitTop = 50
        ExplicitWidth = 786
        object cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel
          OnKeyDown = cxgDadosDBTableViewCitelKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosDBTableViewCitelCPJ_CODEMP: TcxGridDBColumn
            Caption = 'C'#243'digo Empresa'
            DataBinding.FieldName = 'CPJ_CODEMP'
            Options.Editing = False
            Width = 83
          end
          object cxgDadosDBTableViewCitelEMP_NOMEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'EMP_NOMEMP'
            Options.Editing = False
            Width = 280
          end
          object cxgDadosDBTableViewCitelCPJ_CODINS: TcxGridDBColumn
            Caption = 'C'#243'digo Inscri'#231#227'o'
            DataBinding.FieldName = 'CPJ_CODINS'
            Options.Editing = False
            Width = 85
          end
          object cxgDadosDBTableViewCitelINS_DESCRI: TcxGridDBColumn
            Caption = 'Inscri'#231#227'o'
            DataBinding.FieldName = 'INS_DESCRI'
            Options.Editing = False
            Width = 307
          end
        end
        object cxgDadosLevel1: TcxGridLevel
          GridView = cxgDadosDBTableViewCitel
        end
      end
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 8
        Top = 18
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
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
        Left = 70
        Top = 18
        Width = 312
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtDesIns: TEditFocus
        Left = 434
        Top = 18
        Width = 312
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object edtCodIns: TEditFocus
        Tag = 99
        Left = 389
        Top = 18
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 2
        OnKeyPress = edtCodInsKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 2
        TipoTexto = ttAlfanumerico
      end
      object btnAdicionar: TBitBtnLocked
        Left = 755
        Top = 17
        Width = 26
        Height = 25
        Caption = '+'
        TabOrder = 4
        OnClick = btnAdicionarClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 332
    Top = 65532
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 0
  end
  object dtsDados: TDataSource
    Left = 208
    Top = 212
  end
end
