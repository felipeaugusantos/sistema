inherited frmCadRotasRegiao: TfrmCadRotasRegiao
  Width = 708
  Height = 565
  VertScrollBar.Range = 54
  Caption = 'Cadastro de Rotas por Regi'#227'o'
  ExplicitWidth = 708
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 485
    Width = 702
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 485
    ExplicitWidth = 702
    ExplicitHeight = 31
    inherited FlwBotoes: TFlowPanel
      Width = 698
      Height = 27
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitWidth = 698
      ExplicitHeight = 27
      inherited btnIncluir: TBitBtnLocked
        Width = 96
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitWidth = 96
        ExplicitHeight = 25
      end
      inherited btnGravar: TBitBtnLocked
        Left = 96
        Width = 97
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 96
        ExplicitWidth = 97
        ExplicitHeight = 25
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 193
        Width = 96
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 193
        ExplicitWidth = 96
        ExplicitHeight = 25
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 289
        Width = 96
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 289
        ExplicitWidth = 96
        ExplicitHeight = 25
      end
      inherited btnCancela: TBitBtnLocked
        Left = 385
        Width = 96
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 385
        ExplicitWidth = 96
        ExplicitHeight = 25
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 481
        Width = 97
        Height = 25
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        ExplicitLeft = 481
        ExplicitWidth = 97
        ExplicitHeight = 25
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 588
      Top = 3
      Width = 96
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 588
      ExplicitTop = 3
      ExplicitWidth = 96
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 516
    Width = 702
    Height = 20
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 516
    ExplicitWidth = 702
    ExplicitHeight = 20
    inherited pnlNomeForm: TPanel
      Left = 445
      Width = 257
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 445
      ExplicitWidth = 257
      ExplicitHeight = 20
    end
    inherited pnlInfo: TPanel
      Width = 445
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitWidth = 445
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 702
    Height = 485
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 3
    ExplicitWidth = 702
    ExplicitHeight = 485
    inherited tbsGeral: TTabSheet
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitWidth = 694
      ExplicitHeight = 453
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 702
    Height = 485
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlRotas: TPanel
      Left = 1
      Top = 1
      Width = 700
      Height = 140
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object lblRegiao: TLabel
        Left = 89
        Top = 20
        Width = 36
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Regi'#227'o:'
      end
      object Label1: TLabel
        Left = 41
        Top = 109
        Width = 84
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Intervalo Entrega:'
      end
      object Label2: TLabel
        Left = 55
        Top = 79
        Width = 70
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Hor'#225'rio Carga:'
      end
      object Label3: TLabel
        Left = 207
        Top = 78
        Width = 68
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Pedido at'#233' as:'
      end
      object Label6: TLabel
        Left = 438
        Top = 79
        Width = 95
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Valor M'#237'nimo Carga:'
      end
      object lbl4: TLabel
        Left = 47
        Top = 49
        Width = 78
        Height = 14
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object dbeCodReg: TDBEditFocus
        Tag = 99
        Left = 128
        Top = 15
        Width = 68
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        CharCase = ecUpperCase
        DataField = 'ROT_CODREG'
        DataSource = dtsRotReg
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
        OnKeyPress = dbeCodRegKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtDesReg: TEditFocus
        Left = 198
        Top = 15
        Width = 410
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object dbeInterv: TDBEditFocus
        Tag = 99
        Left = 128
        Top = 104
        Width = 68
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        CharCase = ecUpperCase
        DataField = 'ROT_INTERV'
        DataSource = dtsRotReg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object DBEHORCAR: TDBEditFocus
        Tag = 99
        Left = 128
        Top = 74
        Width = 68
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'ROT_HORCAR'
        DataSource = dtsRotReg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEPEDATE: TDBEditFocus
        Tag = 99
        Left = 277
        Top = 74
        Width = 69
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'ROT_HOREMI'
        DataSource = dtsRotReg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEVMINCA: TDBEditFocus
        Tag = 99
        Left = 539
        Top = 74
        Width = 69
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        DataField = 'ROT_VLRMIN'
        DataSource = dtsRotReg
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodTra: TDBEditFocus
        Tag = 99
        Left = 128
        Top = 44
        Width = 68
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        CharCase = ecUpperCase
        DataField = 'ROT_CODTRA'
        DataSource = dtsRotReg
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        OnKeyPress = dbeCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 198
        Top = 44
        Width = 410
        Height = 22
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
    end
    object pgcDadosRota: TPageControl
      Left = 1
      Top = 141
      Width = 700
      Height = 343
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = tbsCidades
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      object tbsCidades: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Cidades'
        object pnlCidades: TPanel
          Left = 0
          Top = 0
          Width = 692
          Height = 311
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object pnlCidade: TPanel
            Left = 1
            Top = 1
            Width = 690
            Height = 72
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object Label8: TLabel
              Left = 29
              Top = 15
              Width = 36
              Height = 14
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Alignment = taRightJustify
              Caption = 'Cidade:'
            end
            object Label5: TLabel
              Left = 33
              Top = 44
              Width = 32
              Height = 14
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Alignment = taRightJustify
              Caption = 'Bairro:'
            end
            object lblSequencia: TLabel
              Left = 472
              Top = 15
              Width = 54
              Height = 14
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Alignment = taRightJustify
              Caption = 'Sequ'#234'ncia:'
            end
            object edtCidade: TEditFocus
              Left = 126
              Top = 11
              Width = 327
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object edtCodCid: TEditFocus
              Tag = 99
              Left = 70
              Top = 11
              Width = 55
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 0
              OnKeyPress = edtCodCidKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object btnAdicionarCid: TBitBtnLocked
              Left = 458
              Top = 40
              Width = 101
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = '&Confirma'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              OnClick = btnAdicionarCidClick
            end
            object btnCancelaItemCid: TBitBtnLocked
              Left = 561
              Top = 40
              Width = 102
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'C&ancelar'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnClick = btnCancelaItemCidClick
            end
            object edtCodBairro: TEditFocus
              Tag = 99
              Left = 70
              Top = 40
              Width = 55
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              MaxLength = 5
              TabOrder = 3
              OnKeyPress = edtCodBairroKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 5
              TipoTexto = ttNumerico
            end
            object edtBairro: TEditFocus
              Left = 126
              Top = 40
              Width = 327
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
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
            object edtSequencia: TEditFocus
              Left = 534
              Top = 11
              Width = 127
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Alignment = taLeftJustify
              MaxLength = 3
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
          end
          object dbgCidades: TcxGrid
            Left = 1
            Top = 73
            Width = 690
            Height = 237
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object dbgCidadesDBTableView1: TcxGridDBTableView
              OnKeyDown = dbgCidadesDBTableView1KeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsRotRec
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.SeparatorWidth = 8
              FixedDataRows.SeparatorWidth = 8
              NewItemRow.SeparatorWidth = 8
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.NavigatorOffset = 63
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibi'#231#227'o'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GroupByBox = False
              OptionsView.IndicatorWidth = 15
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              object dbgCidadesDBTableView1REC_CODREG: TcxGridDBColumn
                DataBinding.FieldName = 'REC_CODREG'
                Visible = False
                MinWidth = 25
              end
              object dbgCidadesDBTableView1REC_CODEMP: TcxGridDBColumn
                DataBinding.FieldName = 'REC_CODEMP'
                Visible = False
                MinWidth = 25
              end
              object dbgCidadesDBTableView1REC_SEQUEN: TcxGridDBColumn
                Caption = 'Seq.'
                DataBinding.FieldName = 'REC_SEQUEN'
                Visible = False
                MinWidth = 25
                Width = 43
              end
              object dbgCidadesDBTableView1REC_CODCID: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'REC_CODCID'
                MinWidth = 25
                Width = 55
              end
              object dbgCidadesDBTableView1AUTOINCREM: TcxGridDBColumn
                DataBinding.FieldName = 'AUTOINCREM'
                Visible = False
                MinWidth = 25
              end
              object dbgCidadesDBTableView1REC_NOMCID: TcxGridDBColumn
                Caption = 'Nome Cidade'
                DataBinding.FieldName = 'REC_NOMCID'
                MinWidth = 25
                Width = 313
              end
              object dbgCidadesDBTableView1REC_ESTADO: TcxGridDBColumn
                Caption = 'UF'
                DataBinding.FieldName = 'REC_ESTADO'
                MinWidth = 25
                Width = 31
              end
              object dbgCidadesDBTableView1REC_NOMBAI: TcxGridDBColumn
                Caption = 'Bairro'
                DataBinding.FieldName = 'REC_NOMBAI'
                MinWidth = 25
                Width = 243
              end
            end
            object dbgCidadesLevel1: TcxGridLevel
              GridView = dbgCidadesDBTableView1
            end
          end
        end
      end
      object tbsVeiculos: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Ve'#237'culos'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlVeiculos: TPanel
          Left = 0
          Top = 0
          Width = 692
          Height = 311
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 0
          object pnlVeiculo: TPanel
            Left = 1
            Top = 1
            Width = 690
            Height = 52
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alTop
            Color = 16770261
            ParentBackground = False
            ShowCaption = False
            TabOrder = 0
            object Label4: TLabel
              Left = 27
              Top = 15
              Width = 38
              Height = 14
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Alignment = taRightJustify
              Caption = 'Ve'#237'culo:'
            end
            object edtDesVei: TEditFocus
              Left = 164
              Top = 11
              Width = 286
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
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
            object btnAdicionarVei: TBitBtnLocked
              Left = 458
              Top = 11
              Width = 101
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = '&Confirma'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnAdicionarVeiClick
            end
            object btnCancelaItemVei: TBitBtnLocked
              Left = 561
              Top = 11
              Width = 101
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = 'C&ancelar'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = btnCancelaItemVeiClick
            end
            object mskPlaVei: TMaskEditFocus
              Tag = 99
              Left = 70
              Top = 11
              Width = 90
              Height = 22
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              CharCase = ecUpperCase
              Enabled = False
              EditMask = 'aaa-9a99;0;_'
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 8
              TabOrder = 0
              Text = ''
              OnKeyPress = mskPlaVeiKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
          end
          object dbgVeiculos: TcxGrid
            Left = 1
            Top = 53
            Width = 690
            Height = 257
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object dbgVeiculosView1: TcxGridDBTableView
              OnDblClick = dbgVeiculosView1DblClick
              OnKeyDown = dbgVeiculosView1KeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsRotRev
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.SeparatorWidth = 8
              FixedDataRows.SeparatorWidth = 8
              NewItemRow.SeparatorWidth = 8
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.NavigatorOffset = 63
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibi'#231#227'o'
              OptionsView.GroupByBox = False
              OptionsView.IndicatorWidth = 15
              Preview.LeftIndent = 25
              Preview.RightIndent = 6
              object cxGridDBColumn1: TcxGridDBColumn
                DataBinding.FieldName = 'REV_CODREG'
                Visible = False
                MinWidth = 25
              end
              object cxGridDBColumn2: TcxGridDBColumn
                DataBinding.FieldName = 'REV_CODEMP'
                Visible = False
                MinWidth = 25
              end
              object cxGridDBColumn3: TcxGridDBColumn
                Caption = 'Placa'
                DataBinding.FieldName = 'REV_PLAVEI'
                MinWidth = 25
                Width = 88
              end
              object cxGridDBColumn4: TcxGridDBColumn
                DataBinding.FieldName = 'AUTOINCREM'
                Visible = False
                MinWidth = 25
              end
              object cxGridDBColumn5: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'REV_DESVEI'
                MinWidth = 25
                Width = 338
              end
              object cxGridDBColumn6: TcxGridDBColumn
                Caption = 'Cap. Carga'
                DataBinding.FieldName = 'REV_CAPCAR'
                MinWidth = 25
              end
              object cxGridDBColumn7: TcxGridDBColumn
                Caption = 'Condutor'
                DataBinding.FieldName = 'REV_CONDUT'
                MinWidth = 25
              end
              object cxGridDBColumn8: TcxGridDBColumn
                Caption = 'Padr'#227'o'
                DataBinding.FieldName = 'REV_PADRAO'
                MinWidth = 25
                Width = 50
              end
            end
            object dbgVeiculosLevel1: TcxGridLevel
              GridView = dbgVeiculosView1
            end
          end
        end
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 48
    Top = 288
  end
  object dtsRotRec: TDataSource
    DataSet = cdsRotRec
    Left = 168
    Top = 224
  end
  object cdsRotRec: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 224
    object cdsRotRecREC_CODREG: TStringField
      FieldName = 'REC_CODREG'
      Size = 5
    end
    object cdsRotRecREC_CODEMP: TStringField
      FieldName = 'REC_CODEMP'
      Size = 3
    end
    object cdsRotRecREC_CODCID: TStringField
      FieldName = 'REC_CODCID'
      Size = 5
    end
    object cdsRotRecAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsRotRecREC_NOMCID: TStringField
      FieldName = 'REC_NOMCID'
      Size = 40
    end
    object cdsRotRecREC_ESTADO: TStringField
      FieldName = 'REC_ESTADO'
      Size = 2
    end
    object cdsRotRecREC_CODBAI: TIntegerField
      FieldName = 'REC_CODBAI'
    end
    object cdsRotRecREC_NOMBAI: TStringField
      FieldName = 'REC_NOMBAI'
      Size = 216
    end
    object cdsRotRecACAO: TStringField
      FieldName = 'ACAO'
      Size = 1
    end
    object cdsRotRecREC_SEQUEN: TFloatField
      FieldName = 'REC_SEQUEN'
      DisplayFormat = '000'
    end
  end
  object dtsRotReg: TDataSource
    Left = 344
  end
  object dtsRotRev: TDataSource
    DataSet = cdsRotRev
    Left = 296
    Top = 224
  end
  object cdsRotRev: TUniClientDataSet
    Aggregates = <>
    Filter = 'ACAO IN ('#39'N'#39','#39'I'#39')'
    Filtered = True
    Params = <>
    Left = 352
    Top = 224
    object cdsRotRevREV_CODREG: TStringField
      FieldName = 'REV_CODREG'
      Size = 5
    end
    object cdsRotRevREV_CODEMP: TStringField
      FieldName = 'REV_CODEMP'
      Size = 3
    end
    object cdsRotRevREV_PLAVEI: TStringField
      FieldName = 'REV_PLAVEI'
      Size = 7
    end
    object cdsRotRevREV_DESVEI: TStringField
      FieldName = 'REV_DESVEI'
      Size = 50
    end
    object cdsRotRevREV_CAPCAR: TIntegerField
      FieldName = 'REV_CAPCAR'
    end
    object cdsRotRevREV_CONDUT: TStringField
      FieldName = 'REV_CONDUT'
      Size = 15
    end
    object cdsRotRevREV_PADRAO: TStringField
      FieldName = 'REV_PADRAO'
      Size = 1
    end
    object cdsRotRevAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsRotRevACAO: TStringField
      FieldName = 'ACAO'
      Size = 1
    end
  end
end
