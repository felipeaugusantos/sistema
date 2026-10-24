inherited frmPedidosRotasRegiao: TfrmPedidosRotasRegiao
  Width = 1024
  Height = 500
  Caption = 'Pedidos de vendas vinculados a rota'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 420
    Width = 1018
    Height = 35
    ExplicitTop = 420
    ExplicitWidth = 1018
    ExplicitHeight = 35
    object lblPesTot: TLabel [0]
      Left = 248
      Top = 8
      Width = 58
      Height = 16
      Caption = 'lblPesTot'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel [1]
      Left = 172
      Top = 8
      Width = 70
      Height = 16
      Caption = 'Peso Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel [2]
      Left = 342
      Top = 8
      Width = 72
      Height = 16
      Caption = 'Valor Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValTot: TLabel [3]
      Left = 420
      Top = 8
      Width = 55
      Height = 16
      Caption = 'lblValTot'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel [4]
      Left = 514
      Top = 8
      Width = 101
      Height = 16
      Caption = 'Valor M'#237'n. Rota:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVlrMin: TLabel [5]
      Left = 621
      Top = 8
      Width = 57
      Height = 16
      Caption = 'lblVlrMin'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 682
      Top = -2
      Width = 23
      Height = 1
      Align = alNone
      Enabled = False
      TabOrder = 2
      ExplicitLeft = 682
      ExplicitTop = -2
      ExplicitWidth = 23
      ExplicitHeight = 1
    end
    object btnAlteraVeiculo: TBitBtnLocked [7]
      Left = 9
      Top = 6
      Width = 124
      Height = 22
      Caption = '[ F2 ] Alterar Ve'#237'culo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnAlteraVeiculoClick
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      Top = 6
      ExplicitLeft = 935
      ExplicitTop = 6
    end
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 1018
    ExplicitTop = 455
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 397
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlRota: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 72
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object grbRota: TGroupBox
        Left = 1
        Top = 1
        Width = 1014
        Height = 70
        Align = alClient
        Caption = 'Rota'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 56
          Top = 10
          Width = 57
          Height = 15
          Caption = 'Seq. Rota:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 70
          Top = 30
          Width = 42
          Height = 15
          Caption = 'Regi'#227'o:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 37
          Top = 50
          Width = 76
          Height = 15
          Caption = 'Data Entrega:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblSeqRota: TLabel
          Left = 117
          Top = 10
          Width = 61
          Height = 15
          Caption = 'lblSeqRota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblRegiao: TLabel
          Left = 117
          Top = 30
          Width = 53
          Height = 15
          Caption = 'lblRegiao'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDataEntrega: TLabel
          Left = 117
          Top = 50
          Width = 82
          Height = 15
          Caption = 'lblDataEntrega'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 354
          Top = 10
          Width = 44
          Height = 15
          BiDiMode = bdLeftToRight
          Caption = 'Ve'#237'culo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBiDiMode = False
          ParentFont = False
        end
        object lblVeiPadrao: TLabel
          Left = 403
          Top = 10
          Width = 69
          Height = 15
          Caption = 'lblVeiPadrao'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object btnCalculaCustoRota: TBitBtnLocked
          Left = 569
          Top = 43
          Width = 144
          Height = 22
          Caption = '[ F3 ] Calcular Custo Rota'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = btnCalculaCustoRotaClick
        end
      end
    end
    object pnlPedidos: TPanel
      Left = 1
      Top = 73
      Width = 1016
      Height = 323
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object dbgRotas: TDBGridCitel
        Left = 1
        Top = 1
        Width = 1014
        Height = 321
        Align = alClient
        DataSource = dtsConsulta
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'FGO_CODCLI'
            Title.Caption = 'C'#243'd. Cliente'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CLI_NOMCLI'
            Title.Caption = 'Nome Cliente'
            Width = 171
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDEST'
            Title.Caption = 'Cidade/Estado'
            Width = 216
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PEDIDO'
            Title.Caption = 'Pedido'
            Width = 128
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DOCFAT'
            Title.Caption = 'Doc. Fat.'
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FGO_VLRCON'
            Title.Caption = 'Valor Pedido'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FGO_PESBRU'
            Title.Caption = 'Peso'
            Width = 71
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FGO_CODVEN'
            Title.Caption = 'Cod. Vend.'
            Width = 57
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OPE_NOMOPE'
            Title.Caption = 'Nome Vend.'
            Width = 111
            Visible = True
          end>
      end
    end
  end
  object ckbLiberaSeparacao: TCheckBox [3]
    Left = 356
    Top = 50
    Width = 165
    Height = 17
    Caption = 'Liberar Impress'#227'o Separa'#231#227'o'
    TabOrder = 2
    OnClick = ckbLiberaSeparacaoClick
  end
  object pnlLegenda: TPanel [4]
    Left = 0
    Top = 397
    Width = 1018
    Height = 23
    Align = alBottom
    Caption = '[Insert] - Inserir Pedido        [Delete] - Excluir Pedido'
    Color = clGray
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 4
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 720
    Top = 8
  end
  object dspConsulta: TUniDataSetProvider
    Options = []
    Left = 576
    Top = 144
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 608
    Top = 144
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 640
    Top = 144
  end
end
