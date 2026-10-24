inherited frmCtrLiberacaoPedidos: TfrmCtrLiberacaoPedidos
  Left = 323
  Top = 237
  Width = 1039
  Height = 618
  Caption = 'Libera'#231#227'o de Pedidos'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnResize = FormResize
  ExplicitTop = -45
  ExplicitWidth = 1039
  ExplicitHeight = 618
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 1033
    Height = 77
    BevelInner = bvNone
    BevelOuter = bvNone
    ExplicitTop = 496
    ExplicitWidth = 1033
    ExplicitHeight = 77
    object Panel1: TPanel [0]
      Left = 0
      Top = 0
      Width = 1033
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
    end
    inherited FlwBotoes: TFlowPanel
      Left = 0
      Top = 0
      Width = 1033
      Height = 77
      Align = alBottom
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 1033
      ExplicitHeight = 77
      object btnSeleciona: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 128
        Height = 25
        Caption = '[ENTER] Seleciona'
        TabOrder = 0
        OnClick = btnSelecionaClick
      end
      object btnAtualizaPed: TBitBtnLocked
        Left = 128
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F2] Atualizar Ped.'
        TabOrder = 1
        OnClick = btnAtualizaPedClick
      end
      object btnCadCli: TBitBtnLocked
        Left = 256
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F3] Cad. Clientes'
        TabOrder = 2
        OnClick = btnCadCliClick
      end
      object btnOcorrencia: TBitBtnLocked
        Left = 384
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F4] Ocorr'#234'ncia'
        TabOrder = 3
        OnClick = btnOcorrenciaClick
      end
      object btnLimparOcorrencia: TBitBtnLocked
        Left = 512
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F5] Limpar Ocorr'#234'ncia'
        TabOrder = 4
        OnClick = btnLimparOcorrenciaClick
      end
      object btnCtaCorrente: TBitBtnLocked
        Left = 640
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F6] Conta Corrente'
        TabOrder = 5
        OnClick = btnCtaCorrenteClick
      end
      object btnResFinanc: TBitBtnLocked
        Left = 768
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F7] Res. Financeiro'
        TabOrder = 6
        OnClick = btnResFinancClick
      end
      object btnReimpressao: TBitBtnLocked
        Left = 896
        Top = 0
        Width = 128
        Height = 25
        Caption = '[F9] Reimpress'#227'o'
        TabOrder = 7
        OnClick = btnReimpressaoClick
      end
      object btnDadFin: TBitBtnLocked
        Left = 0
        Top = 25
        Width = 256
        Height = 25
        Caption = '[F8] Dados do Financiamento'
        TabOrder = 8
        OnClick = btnDadFinClick
      end
      object btnLiberacaoDireta: TBitBtnLocked
        Left = 256
        Top = 25
        Width = 128
        Height = 25
        Caption = '[F10] Libera'#231#227'o Direta'
        TabOrder = 9
        OnClick = btnLiberacaoDiretaClick
      end
      object btnExpandirTodos: TBitBtnLocked
        Left = 384
        Top = 25
        Width = 128
        Height = 25
        Caption = '[F11] [+] Expandir Todos'
        TabOrder = 10
        OnClick = btnExpandirTodosClick
      end
      object btnRetrairTodos: TBitBtnLocked
        Left = 512
        Top = 25
        Width = 128
        Height = 25
        Caption = '[F12] [-] Retrair Todos'
        TabOrder = 11
        OnClick = btnRetrairTodosClick
      end
      object btnCancLib: TBitBtnLocked
        Left = 640
        Top = 25
        Width = 156
        Height = 25
        Caption = '[Ctrl + F2] Cancelar Libera'#231#227'o'
        TabOrder = 12
        OnClick = btnCancLibClick
      end
      object btnPadrao: TBitBtnLocked
        Left = 796
        Top = 25
        Width = 124
        Height = 25
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
        TabOrder = 13
        OnClick = btnPadraoClick
      end
      object btnAlterarDataEntregaRetirada: TBitBtnLocked
        Left = 0
        Top = 50
        Width = 176
        Height = 25
        Caption = 'Alterar Data Entrega/Retirada'
        TabOrder = 14
        OnClick = btnAlterarDataEntregaRetiradaClick
      end
      object btnMnuVendas: TBitBtnLocked
        AlignWithMargins = True
        Left = 177
        Top = 51
        Width = 143
        Height = 25
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[Alt + F3] Inf. de Vendas'
        TabOrder = 15
        OnClick = btnMnuVendasClick
      end
      object btnDesmembrarPedido: TBitBtnLocked
        AlignWithMargins = True
        Left = 322
        Top = 51
        Width = 157
        Height = 25
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[Alt + F4] Desmembrar Pedido'
        TabOrder = 16
        OnClick = btnDesmembrarPedidoClick
      end
      object btnAdiantPed: TBitBtnLocked
        Left = 480
        Top = 50
        Width = 162
        Height = 25
        Caption = '[Alt + F5] Adiantamentos Pedido'
        TabOrder = 17
        Visible = False
        OnClick = btnAdiantPedClick
      end
      object btnConsultaNeocredit: TBitBtnLocked
        AlignWithMargins = True
        Left = 643
        Top = 51
        Width = 176
        Height = 25
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[Alt + F6] Consulta Neocredit'
        TabOrder = 18
        Visible = False
        OnClick = btnConsultaNeocreditClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 930
      Top = 25
      Width = 103
      Height = 24
      Align = alRight
      ExplicitLeft = 930
      ExplicitTop = 25
      ExplicitWidth = 103
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 573
    Width = 1033
    ExplicitTop = 573
    ExplicitWidth = 1033
    inherited pnlNomeForm: TPanel
      Left = 862
      ExplicitLeft = 862
    end
    inherited pnlInfo: TPanel
      Width = 862
      ExplicitWidth = 862
    end
  end
  object pnlRodape: TPanel [2]
    Left = 0
    Top = 464
    Width = 1033
    Height = 32
    Align = alBottom
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    object shpLiberados: TShape
      Left = 300
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clGreen
      Pen.Mode = pmMask
    end
    object Label1: TLabel
      Left = 321
      Top = 9
      Width = 48
      Height = 14
      Caption = 'Liberados'
    end
    object shpBonifica: TShape
      Left = 194
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clRed
      Pen.Mode = pmMask
    end
    object lbl1: TLabel
      Left = 215
      Top = 9
      Width = 63
      Height = 14
      Caption = 'Bonifica'#231#245'es'
    end
    object shpDigVen: TShape
      Left = 8
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clYellow
      Pen.Mode = pmMask
    end
    object lblDigVen: TLabel
      Left = 29
      Top = 9
      Width = 147
      Height = 14
      Caption = 'Digitador '#233' o pr'#243'prio Vendedor'
    end
    object shpVlrMin: TShape
      Left = 386
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = clBlue
      Pen.Mode = pmMask
    end
    object lblVlrMin: TLabel
      Left = 407
      Top = 9
      Width = 111
      Height = 14
      Caption = 'Valor Abaixo do M'#237'nimo'
    end
    object shpNaoHoje: TShape
      Left = 530
      Top = 11
      Width = 16
      Height = 11
      Brush.Color = 14745825
      Pen.Mode = pmMask
    end
    object lblNaoHoje: TLabel
      Left = 551
      Top = 9
      Width = 129
      Height = 14
      Caption = 'N'#227'o Programado Para Hoje'
    end
  end
  object cxgPedidos: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 1033
    Height = 464
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 2
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    OnLayoutChanged = cxgPedidosLayoutChanged
    object cxgPedidosDados: TcxGridDBTableView
      OnKeyDown = cxgPedidosDadosKeyDown
      OnKeyPress = cxgPedidosDadosKeyPress
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
      OnCustomDrawCell = cxgPedidosDadosCustomDrawCell
      DataController.DataSource = dtsPedidos
      DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
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
      FilterRow.InfoText = 'Clique aqui para filtrar os pedidos'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' pedidos para serem exibidos'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxgPedidosDadosFGO_TIPPED: TcxGridDBColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'FGO_TIPPED'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 25
      end
      object cxgPedidosDadosBONIFICA: TcxGridDBColumn
        Caption = 'Bonif.'
        DataBinding.FieldName = 'BONIFICA'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 33
      end
      object cxgPedidosDadosDESTINO: TcxGridDBColumn
        Caption = 'Destino'
        DataBinding.FieldName = 'DESTINO'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 53
      end
      object cxgPedidosDadosFGO_NUMDOC: TcxGridDBColumn
        Caption = 'Pedido'
        DataBinding.FieldName = 'FGO_NUMDOC'
        Options.Editing = False
        Width = 90
      end
      object cxgPedidosDadosFGO_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FGO_CODEMP'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
      end
      object cxgPedidosDadosFGO_EMP_CD: TcxGridDBColumn
        Caption = 'Emp.Destino'
        DataBinding.FieldName = 'FGO_EMP_CD'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
      end
      object cxgPedidosDadosFGO_DTAENT: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o'
        DataBinding.FieldName = 'FGO_DTAENT'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 79
      end
      object cxgPedidosDadosFGO_HORENT: TcxGridDBColumn
        Caption = 'Hr. Emiss'#227'o'
        DataBinding.FieldName = 'FGO_HORENT'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 79
      end
      object cxgPedidosDadosFGO_PREVIS: TcxGridDBColumn
        Caption = 'Dt. Previs'#227'o'
        DataBinding.FieldName = 'PREVIS_DTAHOR'
        Options.Editing = False
        Width = 158
      end
      object cxgPedidosDadosFGO_DTENTR: TcxGridDBColumn
        Caption = 'Dt. Entrega'
        DataBinding.FieldName = 'FGO_DTENTR'
        Options.Editing = False
        Width = 79
      end
      object cxgPedidosDadosFGO_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'FGO_NOMCLI'
        Options.Editing = False
        Width = 37
      end
      object cxgPedidosDadosCGCCPF: TcxGridDBColumn
        Caption = 'PF/PJ'
        DataBinding.FieldName = 'CGCCPF'
        Options.Editing = False
      end
      object cxgPedidosDadosFGO_TIPFRE: TcxGridDBColumn
        Caption = 'Tp. Frete'
        DataBinding.FieldName = 'FGO_TIPFRE'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 60
      end
      object cxgPedidosDadosFGO_TOTFRE: TcxGridDBColumn
        Caption = 'Vlr. Frete'
        DataBinding.FieldName = 'FGO_TOTFRE'
        Options.Editing = False
        Width = 61
      end
      object cxgPedidosDadosTRANSPORTADORA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'TRANSPORTADORA'
        Options.Editing = False
        Width = 85
      end
      object cxgPedidosDadosDIGITADOR: TcxGridDBColumn
        Caption = 'Digitador'
        DataBinding.FieldName = 'DIGITADOR'
        Options.Editing = False
        Width = 47
      end
      object cxgPedidosDadosVENDEDOR: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDEDOR'
        Options.Editing = False
        Width = 52
      end
      object cxgPedidosDadosDESCRI: TcxGridDBColumn
        Caption = 'Departamento do Vendedor'
        DataBinding.FieldName = 'DEP_DESCRI'
        Options.Editing = False
        Width = 140
      end
      object cxgPedidosDadosDESFPG: TcxGridDBColumn
        Caption = 'Forma de Pagamento'
        DataBinding.FieldName = 'DESFPG'
        Options.Editing = False
        Width = 106
      end
      object cxgPedidosDadosCNDDES: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Condi'#231#227'o Pagamento'
        DataBinding.FieldName = 'CND_DESCRI'
        Options.Editing = False
        Width = 106
      end
      object cxgPedidosDadosFGO_CONPAG: TcxGridDBColumn
        Caption = 'Condi'#231#227'o de Pagamento'
        DataBinding.FieldName = 'FGO_CONPAG'
        Options.Editing = False
        Width = 106
      end
      object cxgPedidosDadosDESPAG: TcxGridDBColumn
        Caption = 'Condi'#231#227'o de Pagamento'
        DataBinding.FieldName = 'DESPAG'
        Options.Editing = False
      end
      object cxgPedidosDadosTIPATE: TcxGridDBColumn
        Caption = 'Tipo de Atendimento'
        DataBinding.FieldName = 'TIPATE'
        Options.Editing = False
        Width = 102
      end
      object cxgPedidosDadosFGO_VLRCON: TcxGridDBColumn
        Caption = 'Vlr. Pedido'
        DataBinding.FieldName = 'FGO_VLRCON'
        Options.Editing = False
      end
      object cxgPedidosDadosPORTADOR: TcxGridDBColumn
        Caption = 'Portador'
        DataBinding.FieldName = 'PORTADOR'
        Options.Editing = False
        Width = 52
      end
      object cxgPedidosDadosFGO_STATOS: TcxGridDBColumn
        Caption = 'Status OS'
        DataBinding.FieldName = 'FGO_STATOS'
        Options.Editing = False
        Width = 60
      end
      object cxgPedidosDadosFGO_STATOP: TcxGridDBColumn
        Caption = 'Status OP'
        DataBinding.FieldName = 'FGO_STATOP'
        Options.Editing = False
        Width = 60
      end
      object cxgPedidosDadosFGO_DTALIB: TcxGridDBColumn
        Caption = 'Dt. Libera'#231#227'o'
        DataBinding.FieldName = 'FGO_DTALIB'
        Options.Editing = False
        Width = 69
      end
      object cxgPedidosDadosFGO_HORLIB: TcxGridDBColumn
        Caption = 'Hr. Libera'#231#227'o'
        DataBinding.FieldName = 'FGO_HORLIB'
        Options.Editing = False
        Width = 69
      end
      object cxgPedidosDadosFGO_OPELIB: TcxGridDBColumn
        Caption = 'Ope. Libera'#231#227'o'
        DataBinding.FieldName = 'FGO_OPELIB'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
      end
      object cxgPedidosDadosFGO_TIPOPE: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_TIPOPE'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosVALFUT: TcxGridDBColumn
        DataBinding.FieldName = 'VALFUT'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosVALENT: TcxGridDBColumn
        DataBinding.FieldName = 'VALENT'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosVALRET: TcxGridDBColumn
        DataBinding.FieldName = 'VALRET'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosFGO_LIBERA: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_LIBERA'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosFGO_LIBCOM: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_LIBCOM'
        Visible = False
        Options.Editing = False
      end
      object cxgPedidosDadosFGO_NUMPOK: TcxGridDBColumn
        Caption = 'Pedido Site/Tablet'
        DataBinding.FieldName = 'PEDIDOSITE'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 135
      end
      object cxgPedidosDadosFGO_PEDSIT: TcxGridDBColumn
        Caption = 'Pedido e-commerce'
        DataBinding.FieldName = 'FGO_PEDSIT'
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 122
      end
      object cxgPedidosDadosDESOCO: TcxGridDBColumn
        Caption = 'Ocorr'#234'ncia'
        DataBinding.FieldName = 'DESOCO'
        Options.Editing = False
      end
      object cxgPedidosDadosCLILOJ: TcxGridDBColumn
        Caption = 'Cliente na Loja?'
        DataBinding.FieldName = 'CLILOJ'
        Options.Editing = False
        Width = 90
      end
      object cxgPedidosDadosFGO_ENTURG: TcxGridDBColumn
        Caption = 'Entrega Urgente?'
        DataBinding.FieldName = 'FGO_ENTURG'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.DisplayUnchecked = 'True'
        Properties.DisplayGrayed = 'False'
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        VisibleForEditForm = bTrue
        Width = 100
      end
      object cxgPedidosDadosDIR_ACE_ENTURG: TcxGridDBColumn
        DataBinding.FieldName = 'DIR_ACE_ENTURG'
        BestFitMaxWidth = 10
        MinWidth = 10
        Options.Editing = False
        Options.Filtering = False
        Options.FilteringWithFindPanel = False
        Options.Focusing = False
        Options.IncSearch = False
        Options.FilteringPopupIncrementalFiltering = True
        Options.FilteringPopupMultiSelect = False
        Options.AutoWidthSizable = False
        Options.GroupFooters = False
        Options.Grouping = False
        Options.HorzSizing = False
        Options.Moving = False
        Options.ShowCaption = False
        Options.Sorting = False
        Width = 10
        IsCaptionAssigned = True
      end
      object cxgPedidosDadosNUMCMP: TcxGridDBColumn
        Caption = 'N'#250'mero Pedido de Compra Item'
        DataBinding.FieldName = 'NUMCMP'
        Options.Editing = False
        Width = 200
      end
      object cxgPedidosDadosTOTPRO: TcxGridDBColumn
        Caption = 'Vr. Produto'
        DataBinding.FieldName = 'FGO_TOTPRO'
        Options.Editing = False
      end
      object cxgPedidosDadosDESESP: TcxGridDBColumn
        Caption = 'Vr. Desc. Especial'
        DataBinding.FieldName = 'FGO_DESESP'
        Options.Editing = False
      end
      object cxgPedidosDadosDESACE: TcxGridDBColumn
        Caption = 'Vr. Desp. Acessorias'
        DataBinding.FieldName = 'FGO_DESACE'
        Options.Editing = False
      end
      object cxgPedidosDadosTOTIPI: TcxGridDBColumn
        Caption = 'Vr. IPI'
        DataBinding.FieldName = 'FGO_TOTIPI'
        Options.Editing = False
      end
      object cxgPedidosDadosTOTRET: TcxGridDBColumn
        Caption = 'Vr. ST'
        DataBinding.FieldName = 'FGO_TOTRET'
        Options.Editing = False
      end
      object cxgPedidosDadosVALFCP: TcxGridDBColumn
        Caption = 'Vr. FCP ST'
        DataBinding.FieldName = 'VALFCP'
        Options.Editing = False
      end
      object cxgPedidosDadosFANSOB: TcxGridDBColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'FANSOB'
        Options.Editing = False
      end
      object cxgPedidosDadosSITADT: TcxGridDBColumn
        Caption = 'Adiantamento'
        DataBinding.FieldName = 'SITADT'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = imglSitAdt
        Properties.Items = <
          item
            Description = 'Pendente'
            ImageIndex = 0
            Value = 'Pendente'
          end
          item
            Description = 'Parcialmente'
            ImageIndex = 1
            Value = 'Parcialmente'
          end
          item
            Description = 'Realizado'
            ImageIndex = 2
            Value = 'Realizado'
          end>
        Options.Editing = False
      end
      object cxgPedidosDadosNUMORI: TcxGridDBColumn
        Caption = 'N'#250'mero do Documento de Origem'
        DataBinding.FieldName = 'FGO_NUMORI'
        Options.Editing = False
      end
      object cxgPedidosDadosESPORI: TcxGridDBColumn
        Caption = 'Esp'#233'cie do Documento de Origem'
        DataBinding.FieldName = 'FGO_ESPORI'
        Options.Editing = False
      end
      object cxgPedidosDadosEMPORI: TcxGridDBColumn
        Caption = 'Empresa do Documento de Origem'
        DataBinding.FieldName = 'FGO_EMPORI'
        Options.Editing = False
      end
      object cxgPedidosDadosCODRED: TcxGridDBColumn
        Caption = 'Rede de Lojas'
        DataBinding.FieldName = 'CLI_CODRED'
      end
      object cxgPedidosDadosCODCAC: TcxGridDBColumn
        Caption = 'Canal de Acesso'
        DataBinding.FieldName = 'CLI_CODCAC'
      end
      object cxgPedidosDadosCORILP: TcxGridDBColumn
        Caption = 'Cor Lib Pedido'
        DataBinding.FieldName = 'CAC_CORILP'
        Visible = False
      end
      object cxgPedidosDadosPD_EXP: TcxGridDBColumn
        Caption = 'Liberar para Expedi'#231#227'o Faturar?'
        DataBinding.FieldName = 'PD_EXP'
        Width = 171
      end
      object cxgPedidosDadosSTANEO: TcxGridDBColumn
        Caption = 'Status Neocredit'
        DataBinding.FieldName = 'STANEO'
        OnGetDisplayText = cxgPedidosDadosSTANEOGetDisplayText
        Options.Editing = False
      end
    end
    object cxgMotivosDados: TcxGridDBTableView
      OnKeyDown = cxgPedidosDadosKeyDown
      OnKeyPress = cxgPedidosDadosKeyPress
      OnMouseLeave = cxgMotivosDadosMouseLeave
      OnMouseMove = cxgMotivosDadosMouseMove
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsMotivos
      DataController.DetailKeyFieldNames = 'AUTOINCREM'
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.MasterKeyFieldNames = 'AUTOINCREM'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxgMotivosDadosDIRACE: TcxGridDBColumn
        DataBinding.FieldName = 'DIRACE'
        Visible = False
      end
      object cxgMotivosDadosMOTIVO: TcxGridDBColumn
        DataBinding.FieldName = 'MOTIVO'
        Width = 360
      end
      object cxgMotivosDadosNOMVEN: TcxGridDBColumn
        DataBinding.FieldName = 'NOMVEN'
        Visible = False
      end
      object cxgMotivosDadosVLRCON: TcxGridDBColumn
        DataBinding.FieldName = 'VLRCON'
        Visible = False
      end
      object cxgMotivosDadosCONPAG: TcxGridDBColumn
        DataBinding.FieldName = 'CONPAG'
        Visible = False
      end
      object cxgMotivosDadosINFLIB: TcxGridDBColumn
        DataBinding.FieldName = 'INFLIB'
        Visible = False
      end
    end
    object cxgPedidosNivel: TcxGridLevel
      GridView = cxgPedidosDados
      object cxgMotivosLevel: TcxGridLevel
        GridView = cxgMotivosDados
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 112
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    OnDeactivate = ApplicationEventsDeactivate
    Left = 144
    Top = 40
  end
  object cdsPedidos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedidos'
    AfterOpen = cdsPedidosAfterOpen
    AfterScroll = cdsPedidosAfterScroll
    BeforeRefresh = cdsPedidosBeforeRefresh
    AfterRefresh = cdsPedidosAfterRefresh
    Left = 584
    Top = 352
  end
  object dtsPedidos: TDataSource
    DataSet = cdsPedidos
    OnDataChange = dtsPedidosDataChange
    Left = 520
    Top = 352
  end
  object dspPedidos: TUniDataSetProvider
    DataSet = qryPedidos
    Options = [poDisableInserts, poDisableDeletes]
    Left = 648
    Top = 352
  end
  object qryPedidos: TUniQuery
    Connection = frmModulo.Database
    Left = 712
    Top = 352
  end
  object dtsMotivos: TDataSource
    DataSet = cdsMotivos
    Left = 520
    Top = 408
  end
  object cdsMotivos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 584
    Top = 408
    object cdsMotivosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsMotivosDIRACE: TStringField
      DisplayLabel = 'Trava'
      FieldName = 'DIRACE'
      Size = 7
    end
    object cdsMotivosMOTIVO: TStringField
      DisplayLabel = 'Motivo Bloqueio'
      FieldName = 'MOTIVO'
      Size = 200
    end
    object cdsMotivosNOMVEN: TStringField
      DisplayLabel = 'Vendedor'
      FieldName = 'NOMVEN'
      Size = 50
    end
    object cdsMotivosVLRCON: TFloatField
      DisplayLabel = 'Valor Original'
      FieldName = 'VLRCON'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsMotivosCONPAG: TStringField
      DisplayLabel = 'Condi'#231#227'o de Pagamento'
      FieldName = 'CONPAG'
      Size = 50
    end
    object cdsMotivosINFLIB: TMemoField
      DisplayLabel = 'Informa'#231#245'es para Libera'#231#227'o'
      FieldName = 'INFLIB'
      BlobType = ftMemo
    end
  end
  object cxHint: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Lucida Console'
    HintStyle.Font.Style = []
    Left = 269
    Top = 146
  end
  object popBotoes: TPopupMenu
    Left = 912
    Top = 152
    object mnuVenCli: TMenuItem
      Caption = 'Vendas por Cliente'
      OnClick = mnuVenCliClick
    end
    object mnuSisAnt: TMenuItem
      Caption = 'Vendas do Sistema Anterior'
      OnClick = mnuSisAntClick
    end
  end
  object imglSitAdt: TImageList
    Left = 524
    Top = 184
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000262600008D8D0000CFCF0000F1F10000F3F30000D3D3000091910000
      2C2C000000000000000000000000000000000000000000000000000000000000
      000000262626008D8D8D00CFCFCF00F1F1F100F3F3F300D3D3D300919191002C
      2C2C000000000000000000000000000000000000000000000000000000000000
      0000000F00260037008D005100CF005F00F1005F00F3005300D3003900910011
      002C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000004040000
      8B8B0000FBFB0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FDFD00009797000008080000000000000000000000000000000000040404008B
      8B8B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FD
      FDFD009797970008080800000000000000000000000000000000000200040037
      008B006200FB006400FF006400FF006400FF006400FF006400FF006400FF0063
      00FD003B00970003000800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000004040000AFAF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000BDBD0000080800000000000000000004040400AFAFAF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00BDBDBD00080808000000000000000000020004004500AF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF004A00BD00030008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000089890000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000999900000000000000000089898900FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00999999000000000000000000360089006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF003C0099000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000022220000FBFB0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FDFD000030300022222200FBFBFB00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FDFDFD00303030000D0022006200FB006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006300FD001300300000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000087870000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF000097970087878700FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF0097979700350087006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF003B00970000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C9C90000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000D9D900C9C9C900FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00D9D9D9004F00C9006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF005500D90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E9E90000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000F5F500E9E9E900FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00F5F5F5005B00E9006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF006000F50000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000E9E90000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000F5F500E9E9E900FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00F5F5F5005B00E9006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF006000F50000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C7C70000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000D9D900C7C7C700FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00D9D9D9004E00C7006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF005500D90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000087870000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF000097970087878700FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF0097979700350087006400FF006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006400FF003B00970000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000024240000FBFB0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FDFD00002E2E0024242400FBFBFB00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FDFDFD002E2E2E000E0024006200FB006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF006300FD0012002E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000087870000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000999900000000000000000087878700FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00FFFFFF00999999000000000000000000350087006400FF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF006400FF003C0099000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000004040000AFAF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000BBBB0000080800000000000000000004040400AFAFAF00FF
      FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF
      FFFF00FFFFFF00BBBBBB00080808000000000000000000020004004500AF0064
      00FF006400FF006400FF006400FF006400FF006400FF006400FF006400FF0064
      00FF006400FF004900BB00030008000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000004040000
      89890000FBFB0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FDFD000095950000080800000000000000000000000000000000000404040089
      898900FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FD
      FDFD009595950008080800000000000000000000000000000000000200040036
      0089006200FB006400FF006400FF006400FF006400FF006400FF006400FF0063
      00FD003A00950003000800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000262600008B8B0000CFCF0000F1F10000F1F10000D3D3000091910000
      2A2A000000000000000000000000000000000000000000000000000000000000
      000000262626008B8B8B00CFCFCF00F1F1F100F1F1F100D3D3D300919191002A
      2A2A000000000000000000000000000000000000000000000000000000000000
      0000000F00260037008B005100CF005F00F1005F00F1005300D3003900910010
      002A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
end
