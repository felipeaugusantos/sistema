inherited frmCadFases: TfrmCadFases
  Width = 607
  Height = 436
  Caption = 'Cadastro de Fases'
  ExplicitWidth = 607
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 366
    Width = 601
    Height = 25
    ExplicitTop = 366
    ExplicitWidth = 601
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 597
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 597
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
      object btnSeqFas: TBitBtnLocked
        Left = 444
        Top = 0
        Width = 74
        Height = 20
        Caption = '&Sequ'#234'ncia'
        TabOrder = 6
        OnClick = btnSeqFasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 520
      Width = 72
      Height = 20
      ExplicitLeft = 520
      ExplicitWidth = 72
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 601
    Height = 366
    ActivePage = tbsEquipamentos
    OnChange = pgcDadosChange
    ExplicitWidth = 601
    ExplicitHeight = 363
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 593
      ExplicitHeight = 331
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 593
        Height = 334
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 331
        object Label1: TLabel
          Left = 20
          Top = 10
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 4
          Top = 33
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object dbeDesFas: TDBEditFocus
          Tag = 99
          Left = 58
          Top = 29
          Width = 443
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FAS_DESFAS'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodFas: TDBEditFocus
          Tag = 99
          Left = 58
          Top = 6
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'FAS_CODFAS'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
      end
    end
    object tbsEquipamentos: TTabSheet
      Caption = '&2 - Equipamentos'
      ImageIndex = 1
      ExplicitHeight = 331
      object pnlInclusao: TPanel
        Left = 0
        Top = 41
        Width = 593
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Label3: TLabel
          Left = 8
          Top = 15
          Width = 92
          Height = 14
          Caption = 'Novo equipamento:'
        end
        object edtCodEqp: TEditFocus
          Tag = 99
          Left = 103
          Top = 11
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnExit = edtCodEqpExit
          OnKeyPress = edtCodEqpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesEqp: TEditFocus
          Left = 162
          Top = 11
          Width = 415
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
      end
      object cxgEquipamentos: TcxGrid
        Left = 0
        Top = 90
        Width = 593
        Height = 203
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitHeight = 200
        object cxgEquipamentosView: TcxGridDBTableView
          OnKeyDown = cxgEquipamentosViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgEquipamentosCODEQP: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'EQP_CODEQP'
            Width = 70
          end
          object cxgEquipamentosDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Equipamento'
            DataBinding.FieldName = 'EQP_DESCRI'
            SortIndex = 0
            SortOrder = soAscending
            Width = 383
          end
        end
        object cxgEquipamentosLevel1: TcxGridLevel
          GridView = cxgEquipamentosView
        end
      end
      object pnlDelEQP: TPanel
        Left = 0
        Top = 293
        Width = 593
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitTop = 290
        object btnExcEqp: TBitBtnLocked
          Left = 5
          Top = 10
          Width = 155
          Height = 22
          Caption = '[DEL] Exclui equipamento'
          Enabled = False
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnExcEqpClick
        end
      end
      object mmoTravaFases: TMemo
        Left = 0
        Top = 0
        Width = 593
        Height = 41
        Align = alTop
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        Lines.Strings = (
          
            '                                H'#225' monitoramentos iniciados para' +
            ' essa Fase.'
          
            '              Para alterar os equipamentos fa'#231'a o cancelamento d' +
            'os monitoramentos.')
        ParentFont = False
        TabOrder = 3
        Visible = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 601
    ExplicitTop = 391
    ExplicitWidth = 601
    inherited pnlNomeForm: TPanel
      Left = 392
      Width = 209
      ExplicitLeft = 392
      ExplicitWidth = 209
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 254
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 144
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 72
    Top = 200
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 192
  end
  object dtsTabela: TDataSource
    Left = 257
    Top = 176
  end
end
