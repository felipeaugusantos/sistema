inherited frmCtrLiberaPedidosConf: TfrmCtrLiberaPedidosConf
  Left = 39
  Top = 155
  Width = 1042
  Height = 784
  Caption = 'Libera'#231#227'o de Pedidos - Confirma'#231#227'o'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitTop = -65
  ExplicitWidth = 1042
  ExplicitHeight = 784
  PixelsPerInch = 96
  TextHeight = 14
  object Label30: TLabel [0]
    Left = 582
    Top = 66
    Width = 56
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tot. FCP.ST:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 739
    Width = 1036
    ExplicitTop = 739
    ExplicitWidth = 1036
    DesignSize = (
      1036
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1032
      ExplicitWidth = 1032
    end
  end
  inherited pnlStatus: TPanel
    Top = 739
    Width = 1036
    TabOrder = 3
    ExplicitTop = 739
    ExplicitWidth = 1036
    inherited pnlNomeForm: TPanel
      Left = 865
      TabOrder = 1
      ExplicitLeft = 865
    end
    inherited pnlInfo: TPanel
      Width = 865
      TabOrder = 0
      ExplicitWidth = 865
    end
  end
  inherited pgcDados: TPageControl
    Width = 1036
    Height = 739
    ExplicitWidth = 1036
    ExplicitHeight = 739
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1028
      ExplicitHeight = 707
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1036
    Height = 739
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object pnlMensagens: TPanel
      Left = 0
      Top = 194
      Width = 1036
      Height = 154
      Align = alTop
      ParentColor = True
      TabOrder = 2
      object Label7: TLabel
        Left = 5
        Top = 30
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mensagens:'
      end
      object Label8: TLabel
        Left = 509
        Top = 28
        Width = 69
        Height = 42
        Alignment = taRightJustify
        Caption = 'Obs. para Faturamento / Expedi'#231#227'o:'
        WordWrap = True
      end
      object edtMens01: TEditFocus
        Left = 70
        Top = 25
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 80
        TabOrder = 0
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMens02: TEditFocus
        Left = 70
        Top = 46
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 80
        TabOrder = 1
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenExp: TEditFocus
        Left = 584
        Top = 25
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 70
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx2: TEditFocus
        Left = 584
        Top = 46
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 70
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx3: TEditFocus
        Left = 584
        Top = 67
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 70
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMenEx4: TEditFocus
        Left = 584
        Top = 88
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 70
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlExiMsg: TPanel
        Left = 1
        Top = 1
        Width = 1034
        Height = 22
        Cursor = crHandPoint
        Align = alTop
        Caption = '>>> clique aqui para visualizar as mensagens do pedido <<<'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 6
        StyleElements = [seClient, seBorder]
        OnClick = pnlExiMsgClick
      end
      object btnAltMen: TBitBtnLocked
        Left = 70
        Top = 131
        Width = 127
        Height = 20
        Caption = 'Alterar Mensagem'
        TabOrder = 7
        OnClick = btnAltMenClick
      end
      object btnAltObs: TBitBtnLocked
        Left = 584
        Top = 110
        Width = 127
        Height = 20
        Caption = 'Alterar Observa'#231#227'o'
        TabOrder = 8
        OnClick = btnAltObsClick
      end
      object edtMens03: TEditFocus
        Left = 70
        Top = 67
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 80
        TabOrder = 9
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMens04: TEditFocus
        Left = 70
        Top = 88
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 80
        TabOrder = 10
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtMens05: TEditFocus
        Left = 70
        Top = 109
        Width = 420
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 80
        TabOrder = 11
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlMeio: TPanel
      Left = 0
      Top = 348
      Width = 1036
      Height = 391
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object pgcGeral: TPageControl
        Left = 1
        Top = 1
        Width = 1034
        Height = 389
        ActivePage = tbsItens
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object tbsItens: TTabSheet
          Caption = '&Produtos:'
          object cxgItens: TcxGrid
            Left = 0
            Top = 0
            Width = 1026
            Height = 75
            Align = alClient
            BevelInner = bvLowered
            BorderWidth = 2
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            ExplicitHeight = 101
            object cxgItensDados: TcxGridDBTableView
              Navigator.Buttons.CustomButtons = <>
              Navigator.Buttons.First.Visible = True
              Navigator.Buttons.PriorPage.Visible = True
              Navigator.Buttons.Prior.Visible = True
              Navigator.Buttons.Next.Visible = True
              Navigator.Buttons.NextPage.Visible = True
              Navigator.Buttons.Last.Visible = True
              Navigator.Buttons.Insert.Visible = True
              Navigator.Buttons.Append.Visible = False
              Navigator.Buttons.Delete.Visible = True
              Navigator.Buttons.Edit.Visible = True
              Navigator.Buttons.Post.Visible = True
              Navigator.Buttons.Cancel.Visible = True
              Navigator.Buttons.Refresh.Visible = True
              Navigator.Buttons.SaveBookmark.Visible = True
              Navigator.Buttons.GotoBookmark.Visible = True
              Navigator.Buttons.Filter.Visible = True
              FilterBox.CustomizeDialog = False
              OnCustomDrawCell = cxgItensDadosCustomDrawCell
              DataController.DataSource = dtsItens
              DataController.Summary.DefaultGroupSummaryItems = <
                item
                  Format = '#,##0.00'
                  Kind = skSum
                  Position = spFooter
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                end>
              DataController.Summary.FooterSummaryItems = <
                item
                  Format = ',0.00;(,0.00)'
                  Kind = skSum
                  DisplayText = 'Total'
                end
                item
                  Kind = skCount
                  DisplayText = 'Qtd. Cheques'
                end
                item
                  Format = '#,##0.00'
                  Kind = skSum
                end>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para filtrar os produtos'
              FilterRow.Visible = True
              FilterRow.ApplyChanges = fracImmediately
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' produtos para serem exibidos'
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
            end
            object cxgItensNivel: TcxGridLevel
              GridView = cxgItensDados
            end
          end
          object pnlLegenda: TPanel
            Left = 0
            Top = 75
            Width = 1026
            Height = 22
            Align = alBottom
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentColor = True
            ParentFont = False
            TabOrder = 1
            ExplicitTop = 101
            object imgSetaBaixo: TImage
              Left = 8
              Top = 4
              Width = 15
              Height = 14
              AutoSize = True
              Picture.Data = {
                07544269746D6170D6020000424DD60200000000000036000000280000000F00
                00000E0000000100180000000000A00200000000000000000000000000000000
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A50000FFA5A5A5FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6A5A5A50000FF0000FF0000FFA5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6A5A5A50000FF0000FF0000FF0000FF0000FF
                A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6A5A5A50000
                FF0000FF0000FF0000FF0000FF0000FF0000FFA5A5A5FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6A5A5A50000FF0000FF0000FF0000FF0000FF0000FF0000FF
                0000FF0000FFA5A5A5FFE7D6FFE7D6000000FFE7D6A5A5A5A5A5A5A5A5A5A5A5
                A5A5A5A50000FF0000FF0000FFA5A5A5A5A5A5A5A5A5A5A5A5A5A5A5FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A50000FF0000FF0000FFA5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6A5A5A50000FF0000FF0000FFA5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A50000FF0000FF0000FFA5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6A5A5A50000FF0000FF0000FFA5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000}
            end
            object lblSetaBaixo: TLabel
              Left = 26
              Top = 4
              Width = 220
              Height = 14
              Caption = 'Pr. Ven. L'#237'quido MENOR que Pr. Ven. Sugerido'
            end
            object Bevel1: TBevel
              Left = 261
              Top = 1
              Width = 2
              Height = 21
            end
            object imgSetaCima: TImage
              Left = 269
              Top = 4
              Width = 15
              Height = 15
              AutoSize = True
              Picture.Data = {
                07544269746D617006030000424D060300000000000036000000280000000F00
                00000F0000000100180000000000D00200000000000000000000000000000000
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6A5A5A5008400008400008400A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5008400008400008400A5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6A5A5A5008400008400008400A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6A5A5A5A5A5A5A5A5A5A5A5A5A5A5A5008400008400008400A5A5A5
                A5A5A5A5A5A5A5A5A5A5A5A5FFE7D6000000FFE7D6FFE7D6A5A5A50084000084
                00008400008400008400008400008400008400008400A5A5A5FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6A5A5A5008400008400008400008400008400008400
                008400A5A5A5FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6A5A5
                A5008400008400008400008400008400A5A5A5FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5008400008400008400A5A5A5
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6A5A5A5008400A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000}
            end
            object lblSetaCima: TLabel
              Left = 288
              Top = 4
              Width = 217
              Height = 14
              Caption = 'Pr. Ven. L'#237'quido MAIOR que Pr. Ven. Sugerido'
            end
            object Bevel2: TBevel
              Left = 520
              Top = 1
              Width = 2
              Height = 21
            end
            object imgSetaDireita: TImage
              Left = 528
              Top = 4
              Width = 15
              Height = 15
              AutoSize = True
              Picture.Data = {
                07544269746D617006030000424D060300000000000036000000280000000F00
                00000F0000000100180000000000D00200000000000000000000000000000000
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5A5A5A5FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6A5A5A5FF0000A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5FF0000FF0000
                A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6A5A5A5A5A5A5A5A5A5A5A5
                A5A5A5A5A5A5A5A5A5A5FF0000FF0000FF0000A5A5A5FFE7D6FFE7D6FFE7D600
                0000FFE7D6A5A5A5FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000A5A5A5FFE7D6FFE7D6000000FFE7D6A5A5A5FF0000FF0000FF00
                00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000A5A5A5FFE7D600
                0000FFE7D6A5A5A5FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
                FF0000FF0000A5A5A5FFE7D6FFE7D6000000FFE7D6A5A5A5A5A5A5A5A5A5A5A5
                A5A5A5A5A5A5A5A5A5A5FF0000FF0000FF0000A5A5A5FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5FF0000FF0000
                A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6A5A5A5FF0000A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6A5A5A5A5A5A5FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000FFE7D6FFE7D6FFE7D6FFE7D6FFE7
                D6FFE7D6FFE7D6A5A5A5FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D600
                0000FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6
                FFE7D6FFE7D6FFE7D6FFE7D6FFE7D6000000}
            end
            object lblSetaDireita: TLabel
              Left = 546
              Top = 4
              Width = 209
              Height = 14
              Caption = 'Pr. Ven. L'#237'quido IGUAL ao Pr. Ven. Sugerido'
            end
            object Bevel3: TBevel
              Left = 771
              Top = 1
              Width = 2
              Height = 21
            end
            object Label13: TLabel
              Left = 806
              Top = 4
              Width = 167
              Height = 14
              Caption = '(Vermelho) - Margem Negativa'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              StyleElements = [seClient, seBorder]
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 97
            Width = 1026
            Height = 85
            Align = alBottom
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            ExplicitTop = 123
            object rdgTotProduto: TGroupBox
              Left = 0
              Top = 0
              Width = 1026
              Height = 85
              Margins.Top = 5
              Margins.Bottom = 5
              Align = alClient
              Caption = 'Totaliza'#231#245'es do Produto'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object Label14: TLabel
                Left = 422
                Top = 24
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pr. Venda:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblPreCus: TLabel
                Left = 37
                Top = 22
                Width = 43
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pr.Custo:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblMlPer: TLabel
                Left = 782
                Top = 21
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem L'#237'quida:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label18: TLabel
                Left = 410
                Top = 43
                Width = 13
                Height = 14
                Alignment = taRightJustify
                Caption = 'IPI:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label19: TLabel
                Left = 54
                Top = 41
                Width = 27
                Height = 14
                Alignment = taRightJustify
                Caption = 'ICMS:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label21: TLabel
                Left = 19
                Top = 64
                Width = 62
                Height = 14
                Alignment = taRightJustify
                Caption = '%Com.Vend:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label24: TLabel
                Left = 622
                Top = 41
                Width = 15
                Height = 14
                Alignment = taRightJustify
                Caption = 'ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label2: TLabel
                Left = 205
                Top = 63
                Width = 138
                Height = 13
                Caption = '* Produto em Promo'#231#227'o *'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = [fsBold, fsItalic]
                ParentFont = False
              end
              object Label15: TLabel
                Left = 830
                Top = 42
                Width = 31
                Height = 14
                Alignment = taRightJustify
                Caption = 'DIFAL:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label23: TLabel
                Left = 236
                Top = 42
                Width = 22
                Height = 14
                Alignment = taRightJustify
                Caption = 'FCP:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblMargemLiqComDifal: TLabel
                Left = 773
                Top = 61
                Width = 87
                Height = 14
                Alignment = taRightJustify
                Caption = 'Marg.L'#237'q c/ DIFAL:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label34: TLabel
                Left = 242
                Top = 22
                Width = 67
                Height = 14
                Alignment = taRightJustify
                Caption = 'Pr.Custo Real:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label17: TLabel
                Left = 568
                Top = 22
                Width = 70
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Bruta:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label22: TLabel
                Left = 599
                Top = 62
                Width = 38
                Height = 14
                Alignment = taRightJustify
                Caption = 'FCP-ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object edtPreVen: TEditFocus
                Tag = 99
                Left = 474
                Top = 18
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 2
                Text = '9.999.990,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtCusto: TEditFocus
                Tag = 99
                Left = 84
                Top = 17
                Width = 117
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtMlPer: TEditFocus
                Tag = 99
                Left = 864
                Top = 17
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 5
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtMlVal: TEditFocus
                Tag = 99
                Left = 911
                Top = 17
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 6
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtIPIPer: TEditFocus
                Tag = 99
                Left = 426
                Top = 39
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 11
                Text = '99,99'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtValIcms: TEditFocus
                Tag = 99
                Left = 131
                Top = 38
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 8
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVenPer: TEditFocus
                Tag = 99
                Left = 84
                Top = 59
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 16
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtSitTrib: TEditFocus
                Tag = 99
                Left = 640
                Top = 38
                Width = 118
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 13
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotDif: TEditFocus
                Tag = 99
                Left = 911
                Top = 38
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 15
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtPerFcp: TEditFocus
                Tag = 99
                Left = 263
                Top = 38
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 9
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtValFcp: TEditFocus
                Tag = 99
                Left = 311
                Top = 38
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 10
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtMargemLiqComDifal: TEditFocus
                Tag = 99
                Left = 864
                Top = 59
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 18
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtCustoReal: TEditFocus
                Tag = 99
                Left = 311
                Top = 17
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 1
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtIPIVal: TEditFocus
                Tag = 99
                Left = 474
                Top = 39
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 12
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtPerIcms: TEditFocus
                Tag = 99
                Left = 84
                Top = 38
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 7
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtPerMargemBruta: TEditFocus
                Tag = 99
                Left = 640
                Top = 17
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 3
                Text = '99,90'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtValMargemBruta: TEditFocus
                Tag = 99
                Left = 688
                Top = 17
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtAlDifa: TEditFocus
                Tag = 99
                Left = 864
                Top = 38
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 14
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtLucroLiqComDifal: TEditFocus
                Tag = 99
                Left = 911
                Top = 59
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 19
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtFCPSitTrib: TEditFocus
                Tag = 99
                Left = 640
                Top = 59
                Width = 118
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 17
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
            end
          end
          object pnlTotais: TPanel
            Left = 0
            Top = 182
            Width = 1026
            Height = 108
            Align = alBottom
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 3
            ExplicitTop = 208
            object rdgTotPedido: TGroupBox
              Left = 0
              Top = 0
              Width = 1026
              Height = 108
              Margins.Top = 5
              Margins.Bottom = 5
              Align = alClient
              Caption = 'Totaliza'#231#245'es do Pedido'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object lblTotCus: TLabel
                Left = 58
                Top = 20
                Width = 48
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot.Custo:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblTotICM: TLabel
                Left = 61
                Top = 41
                Width = 44
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot.ICMS:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblTotMLP: TLabel
                Left = 782
                Top = 20
                Width = 78
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem L'#237'quida:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblPreSug: TLabel
                Left = 19
                Top = 62
                Width = 88
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot.Ven. Sugerido:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblDesTotPer: TLabel
                Left = 213
                Top = 62
                Width = 49
                Height = 14
                Alignment = taRightJustify
                Caption = 'Desconto:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblLucroLiqComDifalTot: TLabel
                AlignWithMargins = True
                Left = 770
                Top = 62
                Width = 90
                Height = 14
                Alignment = taRightJustify
                Caption = 'Marg.L'#237'q. c/ DIFAL:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblTotalDifal: TLabel
                Left = 807
                Top = 40
                Width = 51
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. DIFAL:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblTotalFCP: TLabel
                Left = 266
                Top = 41
                Width = 42
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. FCP:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label10: TLabel
                Left = 389
                Top = 62
                Width = 73
                Height = 14
                Alignment = taRightJustify
                Caption = 'Desc.Esp.Ped.:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label28: TLabel
                Left = 429
                Top = 41
                Width = 33
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. IPI:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label29: TLabel
                Left = 599
                Top = 40
                Width = 35
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object lblTotVen: TLabel
                Left = 411
                Top = 20
                Width = 54
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot.Venda: '
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label16: TLabel
                Left = 237
                Top = 21
                Width = 72
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot.Custo Real:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label20: TLabel
                Left = 565
                Top = 21
                Width = 70
                Height = 14
                Alignment = taRightJustify
                Caption = 'Margem Bruta:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label25: TLabel
                Left = 578
                Top = 62
                Width = 56
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. FCP.ST:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label26: TLabel
                Left = 415
                Top = 84
                Width = 47
                Height = 14
                Alignment = taRightJustify
                Caption = 'Vlr. Frete:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label27: TLabel
                Left = 550
                Top = 82
                Width = 84
                Height = 14
                Alignment = taRightJustify
                Caption = 'Vlr. Desp. Acess:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object Label31: TLabel
                Left = 805
                Top = 84
                Width = 55
                Height = 14
                Alignment = taRightJustify
                Caption = 'Tot. Pedido:'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
              object edtTotCus: TEditFocus
                Tag = 99
                Left = 109
                Top = 16
                Width = 92
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 0
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotIcm: TEditFocus
                Tag = 99
                Left = 109
                Top = 37
                Width = 92
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 7
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotMLR: TEditFocus
                Tag = 99
                Left = 911
                Top = 16
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 6
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotMLP: TEditFocus
                Tag = 99
                Left = 864
                Top = 16
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 5
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtTotDes: TEditFocus
                Tag = 99
                Left = 311
                Top = 58
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 14
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotSug: TEditFocus
                Tag = 99
                Left = 109
                Top = 58
                Width = 92
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 12
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotDesPer: TEditFocus
                Tag = 99
                Left = 264
                Top = 58
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 13
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtMargemLiqComDifalTot: TEditFocus
                Tag = 99
                Left = 864
                Top = 58
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 17
                Text = '0,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtLucroLiqComDifalTot: TEditFocus
                Tag = 99
                Left = 911
                Top = 58
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 18
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotDifal: TEditFocus
                Tag = 99
                Left = 864
                Top = 37
                Width = 127
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 11
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotFCP: TEditFocus
                Tag = 99
                Left = 311
                Top = 37
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 8
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtDesEsp: TEditFocus
                Tag = 99
                Left = 464
                Top = 58
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 15
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrTotIPI: TEditFocus
                Tag = 99
                Left = 464
                Top = 37
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 9
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrTotST: TEditFocus
                Tag = 99
                Left = 640
                Top = 37
                Width = 118
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 10
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotVen: TEditFocus
                Tag = 99
                Left = 464
                Top = 16
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 2
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotCusRea: TEditFocus
                Tag = 99
                Left = 311
                Top = 16
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 1
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtTotPerMargBrut: TEditFocus
                Tag = 99
                Left = 640
                Top = 16
                Width = 45
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 3
                Text = '99,00'
                OnEnter = edtPerIcmsEnter
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00%'
              end
              object edtTotValMargBrut: TEditFocus
                Tag = 99
                Left = 688
                Top = 16
                Width = 70
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 4
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrTotFCPST: TEditFocus
                Tag = 99
                Left = 640
                Top = 58
                Width = 118
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 16
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrFrete: TEditFocus
                Tag = 99
                Left = 464
                Top = 79
                Width = 80
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 19
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrDespAcess: TEditFocus
                Tag = 99
                Left = 640
                Top = 79
                Width = 118
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 20
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
              object edtVrTotPed: TEditFocus
                Tag = 99
                Left = 864
                Top = 79
                Width = 127
                Height = 22
                TabStop = False
                Alignment = taRightJustify
                CharCase = ecUpperCase
                Color = 16770261
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                MaxLength = 8
                ParentFont = False
                ReadOnly = True
                TabOrder = 21
                Text = '0,00'
                NormalColor = 16770261
                FocusColor = 16770261
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TamCampo = 8
                TipoTexto = ttNumerico
                EditFormat = '#,##0.00'
              end
            end
          end
          object FlwPnlBotoesLiberacao: TFlowPanel
            Left = 0
            Top = 290
            Width = 1026
            Height = 67
            Align = alBottom
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 4
            OnClick = FlwPnlBotoesLiberacaoClick
            ExplicitLeft = 1
            ExplicitTop = 291
            object btnConfirma: TBitBtnLocked
              Left = 0
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F10] Confirma'
              TabOrder = 0
              OnClick = btnConfirmaClick
            end
            object btnCadCli: TBitBtnLocked
              Left = 127
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F3] Cad. Clientes'
              TabOrder = 1
              OnClick = btnCadCliClick
            end
            object btnOrdemProd: TBitBtnLocked
              Left = 254
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F9] Ord. Produ'#231#227'o'
              TabOrder = 2
              OnClick = btnOrdemProdClick
            end
            object btnMotivoBloq: TBitBtnLocked
              Left = 381
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F4] Motivo Bloqueio'
              TabOrder = 3
              OnClick = btnMotivoBloqClick
            end
            object btnCompCusto: TBitBtnLocked
              Left = 508
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[Ctrl+F4] Compos. Custo'
              TabOrder = 4
              OnClick = btnCompCustoClick
            end
            object btnCadProduto: TBitBtnLocked
              Left = 635
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F5] Cad. Produtos'
              TabOrder = 5
              OnClick = btnCadProdutoClick
            end
            object btnEstoqueLoja: TBitBtnLocked
              Left = 762
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F6] Est. Lojas'
              TabOrder = 6
              OnClick = btnEstoqueLojaClick
            end
            object btnCtaCorrente: TBitBtnLocked
              Left = 889
              Top = 0
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[ F7 ] C./C.'
              TabOrder = 7
              OnClick = btnCtaCorrenteClick
            end
            object btnResFinanc: TBitBtnLocked
              Left = 0
              Top = 20
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[F8] Res. Finan.'
              TabOrder = 8
              OnClick = btnResFinancClick
            end
            object btnFichaKardex: TBitBtnLocked
              Left = 127
              Top = 20
              Width = 127
              Height = 20
              Caption = '[Alt + K] Ficha &Kardex'
              TabOrder = 9
              OnClick = btnFichaKardexClick
            end
            object btnItensComp: TBitBtnLocked
              Left = 254
              Top = 20
              Width = 127
              Height = 20
              Caption = '[F11] Itens Comprados'
              TabOrder = 10
              OnClick = btnItensCompClick
            end
            object btnPadrao: TBitBtnLocked
              Left = 381
              Top = 20
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '&Restaurar Padr'#227'o'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
                015603015603FF00FF0000820000820000820000820000820000820000820000
                820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
                27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
                30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
                FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
                0082000082000082000082000082000082000082000082000082FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
                00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
                0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
                50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
                5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
                8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 11
              OnClick = btnPadraoClick
            end
            object btnAlterarDataEntregaRetirada: TBitBtnLocked
              Left = 508
              Top = 20
              Width = 156
              Height = 20
              Caption = 'Alterar Data Entrega/Retirada'
              TabOrder = 12
              OnClick = btnAlterarDataEntregaRetiradaClick
            end
            object btnAltConPag: TBitBtnLocked
              Left = 664
              Top = 20
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[Ctrl + F7] Alt.Cnd.Pagto'
              TabOrder = 13
              OnClick = btnAltConPagClick
            end
            object btnAdiantPed: TBitBtnLocked
              Left = 791
              Top = 20
              Width = 162
              Height = 20
              Caption = '[Alt + F5] Adiantamentos Pedido'
              TabOrder = 14
              Visible = False
              OnClick = btnAdiantPedClick
            end
            object btnCancela: TBitBtnLocked
              Left = 0
              Top = 40
              Width = 127
              Height = 20
              Align = alLeft
              Caption = '[Esc] Cancelar'
              TabOrder = 15
              OnClick = btnCancelaClick
            end
          end
        end
        object tbsCRM: TTabSheet
          Caption = '&Ocorr'#234'ncias CRM:'
          ImageIndex = 1
          object pnlCRM: TPanel
            Left = 0
            Top = 0
            Width = 1026
            Height = 357
            Align = alClient
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
          end
        end
      end
    end
    object pnlTopo: TPanel
      Left = 0
      Top = 0
      Width = 1036
      Height = 194
      Align = alTop
      AutoSize = True
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object pnlCndPag: TPanel
        Left = 1
        Top = 98
        Width = 1034
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label33: TLabel
          Left = 2
          Top = 5
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desc Cond. Pagto:'
        end
        object edtCodCnd: TEditFocus
          Tag = 99
          Left = 93
          Top = 0
          Width = 48
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCnd: TEditFocus
          Left = 142
          Top = 0
          Width = 488
          Height = 22
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
      end
      object Panel3: TPanel
        Left = 1
        Top = 1
        Width = 1034
        Height = 97
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 54
          Top = 10
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pedido:'
        end
        object Label3: TLabel
          Left = 56
          Top = 33
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object Label4: TLabel
          Left = 41
          Top = 56
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vendedor:'
        end
        object Label5: TLabel
          Left = 499
          Top = 10
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Emiss'#227'o:'
        end
        object lblCndPag: TLabel
          Left = 30
          Top = 79
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cond. Pagto:'
        end
        object Label12: TLabel
          Left = 176
          Top = 10
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object spbDuplicatas: TSpeedButton
          Left = 635
          Top = 74
          Width = 248
          Height = 22
          Caption = 'Pressione [ F1 ] para visualizar as Duplicatas'
          Flat = True
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
            83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
            DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
            AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
            00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
            E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
            3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
            ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
            CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
            00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
            F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
            0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
            D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
            2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
            43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
            DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
            FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
            0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
            82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          OnClick = spbDuplicatasClick
        end
        object lblBonificacao: TLabel
          Left = 640
          Top = 29
          Width = 133
          Height = 22
          Caption = 'BONIFICA'#199#195'O'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          Visible = False
          StyleElements = [seClient, seBorder]
        end
        object Label11: TLabel
          Left = 259
          Top = 10
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pedido Site/Tablet:'
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 93
          Top = 29
          Width = 80
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 174
          Top = 29
          Width = 456
          Height = 22
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
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 93
          Top = 52
          Width = 80
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomVen: TEditFocus
          Left = 174
          Top = 52
          Width = 456
          Height = 22
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
        object mskCndPag: TMaskEditFocus
          Tag = 99
          Left = 93
          Top = 74
          Width = 537
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Enabled = False
          EditMask = 
            '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
            '99.999.999.999.999.999.999.999.999;0;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 98
          TabOrder = 4
          Text = ''
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtNumDoc: TEditFocus
          Tag = 99
          Left = 93
          Top = 6
          Width = 80
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtDtaEnt: TEditFocus
          Tag = 99
          Left = 543
          Top = 6
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 222
          Top = 6
          Width = 34
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNumSite: TEditFocus
          Tag = 99
          Left = 350
          Top = 6
          Width = 144
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 12
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttAlfanumerico
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 121
        Width = 1034
        Height = 72
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object Label6: TLabel
          Left = 13
          Top = 27
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Transportadora:'
        end
        object Label9: TLabel
          Left = 13
          Top = 4
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Forma de Pagto:'
        end
        object Label32: TLabel
          Left = 52
          Top = 50
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Entrega:'
        end
        object edtCodTra: TEditFocus
          Tag = 99
          Left = 93
          Top = 23
          Width = 48
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTra: TEditFocus
          Left = 142
          Top = 23
          Width = 488
          Height = 22
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
        object edtCodFpg: TEditFocus
          Tag = 99
          Left = 93
          Top = 0
          Width = 48
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesFpg: TEditFocus
          Left = 142
          Top = 0
          Width = 488
          Height = 22
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
        object edtDtaEntrega: TEditFocus
          Tag = 99
          Left = 93
          Top = 46
          Width = 87
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 968
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 1000
    Top = 128
  end
  object dtsItens: TDataSource
    Left = 968
    Top = 128
  end
  object qryTotais: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 1000
    Top = 160
  end
end
