inherited frmCadGruposAnaliseProducao: TfrmCadGruposAnaliseProducao
  Width = 578
  Height = 465
  Caption = 'Grupos An'#225'lise Produ'#231#227'o'
  ExplicitWidth = 578
  ExplicitHeight = 465
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 394
    Width = 572
    Height = 26
    ExplicitTop = 394
    ExplicitWidth = 572
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 568
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 568
      inherited btnIncluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Height = 22
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 81
        Height = 22
        ExplicitWidth = 81
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 495
      ExplicitLeft = 495
    end
  end
  inherited pnlStatus: TPanel
    Top = 420
    Width = 572
    ExplicitTop = 420
    ExplicitWidth = 572
    inherited pnlNomeForm: TPanel
      Left = 225
      ExplicitLeft = 225
    end
    inherited pnlInfo: TPanel
      Width = 225
      ExplicitWidth = 225
    end
  end
  inherited pgcDados: TPageControl
    Width = 572
    Height = 394
    ExplicitWidth = 572
    ExplicitHeight = 392
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 564
      ExplicitHeight = 360
      object cxgGruDet: TcxGridCitel
        Left = 0
        Top = 129
        Width = 564
        Height = 233
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 231
        object cxgGruDetTbv: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgGruDetTbvGRD_CODGRU: TcxGridDBColumn
            Caption = 'Linha/Grupo'
            DataBinding.FieldName = 'GRD_CODGRU'
            Width = 82
          end
          object cxgGruDetTbvGRU_DESGRU: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'GRU_DESGRU'
            Width = 392
          end
        end
        object cxgGruDetLvl: TcxGridLevel
          GridView = cxgGruDetTbv
        end
      end
      object pnlCabecalho: TPanel
        Left = 0
        Top = 0
        Width = 564
        Height = 61
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 7
          Width = 33
          Height = 14
          Caption = 'C'#243'digo'
        end
        object Label2: TLabel
          Left = 75
          Top = 7
          Width = 49
          Height = 14
          Caption = 'Descri'#231#227'o'
        end
        object dbeCodGru: TDBEditFocus
          Left = 7
          Top = 24
          Width = 65
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'GRG_CODIGO'
          DataSource = dtsGruGer
          Enabled = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 75
          Top = 24
          Width = 478
          Height = 22
          DataField = 'GRG_DESCRI'
          DataSource = dtsGruGer
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlLinhaGrupo: TPanel
        Left = 0
        Top = 61
        Width = 564
        Height = 68
        Align = alTop
        TabOrder = 1
        object Label3: TLabel
          Left = 7
          Top = 12
          Width = 65
          Height = 14
          Caption = 'Linha / Grupo'
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 7
          Top = 29
          Width = 86
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
      end
    end
  end
  object dtsGruGer: TDataSource
    Left = 496
    Top = 32
  end
end
