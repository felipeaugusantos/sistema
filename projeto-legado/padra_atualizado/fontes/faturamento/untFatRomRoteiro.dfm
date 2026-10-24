inherited frmFatRomRoteiro: TfrmFatRomRoteiro
  Left = 339
  Top = 321
  Width = 980
  Height = 619
  VertScrollBar.Range = 56
  Caption = 'Roteiro de Entrega  - Romaneio'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 980
  ExplicitHeight = 619
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 536
    Width = 974
    Height = 34
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 814
    ExplicitWidth = 1093
    ExplicitHeight = 34
    inherited FlwBotoes: TFlowPanel
      Width = 874
      Height = 30
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitWidth = 993
      ExplicitHeight = 30
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 175
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnMoveCima: TBitBtnLocked
        Left = 175
        Top = 0
        Width = 200
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '[ F5 ] Move Documento p/ Cima'
        TabOrder = 1
        OnClick = btnMoveCimaClick
      end
      object btnMoveBaixo: TBitBtnLocked
        Left = 375
        Top = 0
        Width = 200
        Height = 28
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = '[ F6 ] Move Documento p/ Baixo'
        TabOrder = 2
        OnClick = btnMoveBaixoClick
      end
      object btnRotaAPI: TBitBtnLocked
        Left = 575
        Top = 0
        Width = 114
        Height = 28
        Caption = '[ F9 ] Rota'
        TabOrder = 3
        Visible = False
        OnClick = btnRotaAPIClick
      end
      object btnInfo: TBitBtnLocked
        Left = 689
        Top = 0
        Width = 25
        Height = 28
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000800000010000000100000
          0008000000010000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
          0B60000000070000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
          27EA0000000E0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
          30EC0000000D0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
          1A51000000050000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000600000011000000140000
          000A000000020000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000670503AA999532EFF4528
          187A000000070000000100000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
          4AF724150D490000000800000002000000000000000000000000000000000000
          0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
          9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
          000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
          AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
          00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
          76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
          000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
          70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
          000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
          C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
          0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
          77E570533B9A17100A2500000002000000000000000000000000000000000000
          0000000000000000000000000000000000010000000100000002000000030000
          0002000000020000000100000000000000000000000000000000}
        TabOrder = 4
        Visible = False
        OnClick = btnInfoClick
      end
      object btnVisualizarMapa: TBitBtnLocked
        Left = 714
        Top = 0
        Width = 136
        Height = 28
        Caption = '[ F12 ] Visualizar Mapa'
        TabOrder = 5
        Visible = False
        OnClick = btnVisualizarMapaClick
      end
      object btnConsultaEndereco: TBitBtnLocked
        Left = 0
        Top = 28
        Width = 160
        Height = 28
        Caption = 'Consultar Endere'#231'o no Google'
        TabOrder = 6
        Visible = False
        OnClick = btnConsultaEnderecoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 876
      Top = 2
      Width = 96
      Height = 30
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      ExplicitLeft = 995
      ExplicitTop = 2
      ExplicitWidth = 96
      ExplicitHeight = 30
    end
  end
  inherited pnlStatus: TPanel
    Top = 570
    Width = 974
    Height = 20
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ExplicitTop = 848
    ExplicitWidth = 1093
    ExplicitHeight = 20
    inherited pnlNomeForm: TPanel
      Left = 760
      Width = 214
      Height = 0
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ExplicitLeft = 879
      ExplicitWidth = 214
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 974
      Height = 20
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alBottom
      ExplicitWidth = 1093
      ExplicitHeight = 20
    end
    inherited pnlBotoesTrace: TPanel
      Height = 0
      ExplicitHeight = 0
      inherited btnIniciarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 20
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 20
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 20
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 20
      end
    end
  end
  object splDefRota: TSplitView [2]
    Left = 974
    Top = 0
    Width = 0
    Height = 536
    AnimationDelay = 5
    AnimationStep = 60
    BiDiMode = bdLeftToRight
    Opened = False
    OpenedWidth = 246
    ParentBiDiMode = False
    Placement = svpRight
    TabOrder = 2
    ExplicitLeft = 1093
    ExplicitHeight = 814
    object scrRota: TScrollBox
      Left = 0
      Top = 0
      Width = 0
      Height = 536
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitHeight = 814
      object rdgPtInic: TRadioGroup
        Left = 0
        Top = 0
        Width = 0
        Height = 73
        Align = alTop
        Caption = 'Origem'
        ItemIndex = 0
        Items.Strings = (
          'Centro de Distribui'#231#227'o'
          'Endere'#231'o do Motorista')
        TabOrder = 0
        OnClick = rdgPtInicClick
      end
      object rdgCaminho: TRadioGroup
        Left = 0
        Top = 205
        Width = 0
        Height = 90
        Align = alTop
        Caption = 'Caminho'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Considerar o caminho mais r'#225'pido'
          'Considerar o caminho com menor quilometragem')
        ParentFont = False
        TabOrder = 1
        WordWrap = True
      end
      object rdgTrajetoGoogle: TRadioGroup
        Left = 0
        Top = 557
        Width = 0
        Height = 75
        Align = alTop
        Caption = 'Trajeto'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Nenhum'
          'Evitar Ped'#225'gios'
          'Evitar Rodovias'
          'Evitar Balsas')
        TabOrder = 2
      end
      object gpbTrajetoMaplink: TGroupBox
        Left = 0
        Top = 632
        Width = 0
        Height = 120
        Align = alTop
        Caption = 'Trajeto'
        TabOrder = 3
        object chkTunnels: TCheckBox
          Left = 13
          Top = 21
          Width = 97
          Height = 17
          Caption = 'Evitar T'#250'neis'
          TabOrder = 0
        end
        object chkBridges: TCheckBox
          Left = 13
          Top = 55
          Width = 97
          Height = 17
          Caption = 'Evitar Pontes'
          TabOrder = 1
        end
        object chkFerries: TCheckBox
          Left = 13
          Top = 90
          Width = 97
          Height = 17
          Caption = 'Evitar Balsas'
          TabOrder = 2
        end
        object chkTollRoads: TCheckBox
          Left = 128
          Top = 37
          Width = 97
          Height = 53
          Caption = 'Evitar Rodovias com Ped'#225'gios'
          TabOrder = 3
          WordWrap = True
        end
        object chkTollGates: TCheckBox
          Left = 128
          Top = 21
          Width = 97
          Height = 17
          Caption = 'Evitar Ped'#225'gios'
          TabOrder = 4
        end
      end
      object gpbLibMot: TGroupBox
        Left = 0
        Top = 752
        Width = 0
        Height = 53
        Align = alTop
        TabOrder = 4
        object Label1: TLabel
          Left = 13
          Top = 6
          Width = 206
          Height = 14
          Caption = 'Romaneio liberado para o Citel T'#225' Entregue'
        end
        object ColorLabel22: TColorLabel
          Left = 42
          Top = 27
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtLibApp: TEditFocus
          Tag = 99
          Left = 13
          Top = 23
          Width = 26
          Height = 22
          Alignment = taCenter
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object btnCalcularRota: TBitBtnLocked
        Left = 0
        Top = 805
        Width = 0
        Height = 29
        Align = alTop
        Caption = '[F11] Planejar Rota'
        TabOrder = 5
        OnClick = btnCalcularRotaClick
      end
      object gbpOpcOrd: TGroupBox
        Left = 0
        Top = 295
        Width = 0
        Height = 262
        Align = alTop
        Caption = 'Planejamento'
        TabOrder = 6
        object rdbMelhorRota: TRadioButton
          Left = 2
          Top = 16
          Width = 221
          Height = 23
          Align = alTop
          Caption = 'Calcular Melhor Rota'
          TabOrder = 0
          OnClick = rdbMelhorRotaClick
        end
        object rdbSelPertoLonge: TRadioButton
          Tag = 3
          Left = 2
          Top = 119
          Width = 221
          Height = 50
          Align = alTop
          Caption = 
            'Iniciar no local de entrega que est'#225' posicionado na lista e term' +
            'inar no local de entrega mais longe'
          TabOrder = 1
          WordWrap = True
          OnClick = rdbSelPertoLongeClick
        end
        object rdbPertoLonge: TRadioButton
          Tag = 1
          Left = 2
          Top = 39
          Width = 221
          Height = 40
          Align = alTop
          Caption = 
            'Iniciar no local de entrega mais perto e terminar no local de en' +
            'trega mais longe'
          TabOrder = 2
          WordWrap = True
          OnClick = rdbPertoLongeClick
        end
        object rdbSelLongePerto: TRadioButton
          Tag = 4
          Left = 2
          Top = 169
          Width = 221
          Height = 50
          Align = alTop
          Caption = 
            'Iniciar no local de entrega que est'#225' posicionado na lista e term' +
            'inar no local de entrega mais perto'
          TabOrder = 3
          WordWrap = True
          OnClick = rdbSelLongePertoClick
        end
        object rdbLongePerto: TRadioButton
          Tag = 2
          Left = 2
          Top = 79
          Width = 221
          Height = 40
          Align = alTop
          Caption = 
            'Iniciar no local de entrega mais longe e terminar no local de en' +
            'trega mais perto'
          TabOrder = 4
          WordWrap = True
          OnClick = rdbLongePertoClick
        end
        object rdbDefinido: TRadioButton
          Tag = 5
          Left = 2
          Top = 219
          Width = 221
          Height = 40
          Align = alTop
          Caption = 'Calcular conforme ordena'#231#227'o definida manualmente'
          TabOrder = 5
          WordWrap = True
          OnClick = rdbDefinidoClick
        end
      end
      object gpbConclusaoRomaneio: TGroupBox
        Left = 0
        Top = 73
        Width = 0
        Height = 132
        Align = alTop
        Caption = 'Defini'#231#227'o da conclus'#227'o do Romaneio'
        TabOrder = 7
        object rdbRetornarLoja: TRadioButton
          Left = 8
          Top = 18
          Width = 217
          Height = 30
          Caption = 'Haver'#225' retorno para a loja geradora do romaneio'
          Checked = True
          TabOrder = 0
          TabStop = True
          WordWrap = True
        end
        object rdbNaoRetornar: TRadioButton
          Left = 8
          Top = 92
          Width = 211
          Height = 26
          Caption = 'Termina no endere'#231'o de entrega do '#250'ltimo documento'
          TabOrder = 1
          WordWrap = True
        end
        object rdbRetornarEndMotorista: TRadioButton
          Left = 8
          Top = 56
          Width = 215
          Height = 25
          Caption = 'Haver'#225' retorno para a resid'#234'ncia do motorista'
          TabOrder = 2
          WordWrap = True
          OnClick = rdbRetornarEndMotoristaClick
        end
      end
    end
  end
  object pnlRota: TPanel [3]
    Left = 0
    Top = 0
    Width = 974
    Height = 536
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitWidth = 1093
    ExplicitHeight = 814
    object gpbFiliais: TGroupBox
      Left = 0
      Top = 0
      Width = 974
      Height = 153
      Align = alTop
      Caption = 'As empresas marcadas far'#227'o parte da rota para coleta do material'
      TabOrder = 0
      Visible = False
      ExplicitWidth = 1093
      object cxgCarga: TcxGridCitel
        Left = 2
        Top = 16
        Width = 970
        Height = 135
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 1089
        object cxgCargaDBTableViewCitel: TcxGridDBTableViewCitel
          OnDblClick = cxgCargaDBTableViewCitelDblClick
          OnKeyDown = cxgCargaDBTableViewCitelKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgCargaDBTableViewCitelCustomDrawCell
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgCargaMARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
          end
          object cxgCargaEMP_CODEMP: TcxGridDBColumn
            Caption = 'C'#243'd. Emp.'
            DataBinding.FieldName = 'EMP_CODEMP'
            Width = 55
          end
          object cxgCargaEMP_NOMEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'EMP_NOMEMP'
            Width = 300
          end
          object cxgCargaEMP_C_G_C_: TcxGridDBColumn
            Caption = 'CNPJ'
            DataBinding.FieldName = 'EMP_C_G_C_'
            Width = 120
          end
          object cxgCargaEMP_ENDERE: TcxGridDBColumn
            Caption = 'Endere'#231'o'
            DataBinding.FieldName = 'EMP_ENDERE'
            Width = 300
          end
          object cxgCargaEMP_BAIRRO: TcxGridDBColumn
            Caption = 'Bairro'
            DataBinding.FieldName = 'EMP_BAIRRO'
            Width = 186
          end
          object cxgCargaEMP_C_E_P_: TcxGridDBColumn
            Caption = 'CEP'
            DataBinding.FieldName = 'EMP_C_E_P_'
            Width = 75
          end
          object cxgCargaEMP_CODCID: TcxGridDBColumn
            Caption = 'C'#243'd. Cidade'
            DataBinding.FieldName = 'EMP_CODCID'
            Visible = False
          end
          object cxgCargaCID_NOMCID: TcxGridDBColumn
            Caption = 'Cidade'
            DataBinding.FieldName = 'CID_NOMCID'
            Width = 200
          end
          object cxgCargaCID_ESTADO: TcxGridDBColumn
            Caption = 'UF'
            DataBinding.FieldName = 'CID_ESTADO'
            Width = 30
          end
        end
        object cxgCargaLevel: TcxGridLevel
          GridView = cxgCargaDBTableViewCitel
        end
      end
      object geolocalizacao: TTMSFNCGeocoding
        Left = 400
        Top = 88
        Width = 26
        Height = 26
        Visible = True
        GeocodingRequests = <>
      end
    end
    object gpbEntregas: TGroupBox
      Left = 0
      Top = 153
      Width = 974
      Height = 360
      Align = alClient
      Caption = 'Entregas'
      TabOrder = 1
      ExplicitWidth = 1093
      ExplicitHeight = 638
      object cxgItens: TcxGridCitel
        Left = 2
        Top = 16
        Width = 970
        Height = 342
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitWidth = 1089
        ExplicitHeight = 620
        object cxgItensDBTableViewCitel: TcxGridDBTableViewCitel
          OnDblClick = cxgItensDBTableViewCitelDblClick
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = cxgItensDBTableViewCitelCellClick
          OnCustomDrawCell = cxgItensDBTableViewCitelCustomDrawCell
          DataController.DataSource = dtsTmpDoc
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
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GER_PRIORI: TcxGridDBColumn
            Caption = 'Prioridade'
            DataBinding.FieldName = 'PRIORIDADE'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.Images = cxImageList
            Properties.ImmediatePost = True
            Properties.Items = <
              item
                Description = 'NORMAL'
                Value = '0'
              end
              item
                Description = 'ENTRE AS PRIMEIRAS'
                ImageIndex = 4
                Value = '1'
              end
              item
                Description = 'ENTRE AS '#218'LTIMAS'
                ImageIndex = 5
                Value = '2'
              end>
            Properties.ReadOnly = False
            Properties.ShowDescriptions = False
            Visible = False
            Options.AutoWidthSizable = False
            Width = 55
          end
          object GER_SEQUEN: TcxGridDBColumn
            Caption = 'Seq.'
            DataBinding.FieldName = 'GER_SEQUEN'
            Options.Editing = False
            Width = 45
          end
          object GER_NUMDOC: TcxGridDBColumn
            Caption = 'Documento'
            DataBinding.FieldName = 'GER_NUMDOC'
            Options.Editing = False
          end
          object GER_CODEMP: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'GER_CODEMP'
            Options.Editing = False
          end
          object GER_NOMCLI: TcxGridDBColumn
            Caption = 'Cliente/Descri'#231#227'o Entr.'
            DataBinding.FieldName = 'GER_NOMCLI'
            Options.Editing = False
          end
          object GER_NOMCID: TcxGridDBColumn
            Caption = 'Cidade'
            DataBinding.FieldName = 'GER_NOMCID'
            Options.Editing = False
          end
          object GER_ESTADO: TcxGridDBColumn
            Caption = 'UF'
            DataBinding.FieldName = 'GER_ESTADO'
            Options.Editing = False
          end
          object GER_BAIRRO: TcxGridDBColumn
            Caption = 'Bairro'
            DataBinding.FieldName = 'GER_BAIRRO'
            Options.Editing = False
          end
          object GER_ENDCON: TcxGridDBColumn
            Caption = 'End. Entrega'
            DataBinding.FieldName = 'GER_ENDCON'
            Options.Editing = False
          end
          object GER_CEPCON: TcxGridDBColumn
            Caption = 'CEP Entrega'
            DataBinding.FieldName = 'GER_CEPCON'
            Options.Editing = False
          end
          object GER_TRANSP: TcxGridDBColumn
            Caption = 'Transportadora'
            DataBinding.FieldName = 'GER_TRANSP'
            Options.Editing = False
          end
          object GER_ORDIMP: TcxGridDBColumn
            Caption = 'Rota'
            DataBinding.FieldName = 'GER_ORDIMP'
            Options.Editing = False
          end
          object DISTAENTREGA: TcxGridDBColumn
            Caption = 'Dist'#226'ncia Km'
            DataBinding.FieldName = 'DISTAENTREGA'
            Visible = False
            HeaderHint = 
              'A coluna "Dist'#226'ncia KM" exibe a dist'#226'ncia considerando o ponto d' +
              'e partida e o ponto de entrega para o primeiro documento da rota' +
              ' e depois considera '#10'a dist'#226'ncia entre a entrega atual e a pr'#243'xi' +
              'ma entrega.'
            Options.Editing = False
          end
          object TEMPOENTREGA: TcxGridDBColumn
            Caption = 'Tempo Dist'#226'ncia'
            DataBinding.FieldName = 'TEMPOENTREGA'
            Visible = False
            HeaderHint = 
              'A coluna "Tempo Dist'#226'ncia" exibe o tempo considerando o ponto de' +
              ' partida e o ponto de entrega para o primeiro documento da rota ' +
              'e depois considera '#10'a dist'#226'ncia entre a entrega atual e a pr'#243'xim' +
              'a entrega.'
            Options.Editing = False
          end
          object DISTACUMULADA: TcxGridDBColumn
            Caption = 'Percurso Km'
            DataBinding.FieldName = 'DISTACUMULADA'
            Visible = False
            Options.Editing = False
          end
          object TEMPOACUMULADO: TcxGridDBColumn
            Caption = 'Tempo Percurso'
            DataBinding.FieldName = 'TEMPOACUMULADO'
            Visible = False
            HeaderHint = 
              'A coluna "Tempo Percurso" exibe o tempo considerando o ponto de ' +
              'partida e o percurso que ser'#225' feito conforme a rota definida.'
            Options.Editing = False
          end
          object GER_LOCALI: TcxGridDBColumn
            Caption = 'Ret. API'
            DataBinding.FieldName = 'GER_LOCALI'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.ImageAlign = iaRight
            Properties.Images = cxImageList
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 'OK'
              end
              item
                ImageIndex = 1
                Value = 'ERRO'
              end
              item
                ImageIndex = 2
                Value = ''
              end
              item
                ImageIndex = 3
                Value = 'OK?'
              end>
            Properties.ReadOnly = True
            Properties.ShowDescriptions = False
            Visible = False
            Options.Editing = False
          end
          object GER_FILIAL: TcxGridDBColumn
            DataBinding.FieldName = 'GER_FILIAL'
            Visible = False
            Options.Editing = False
          end
        end
        object cxgItensLevel: TcxGridLevel
          GridView = cxgItensDBTableViewCitel
        end
      end
    end
    object pnlLegenda: TPanel
      Left = 0
      Top = 513
      Width = 974
      Height = 23
      Align = alBottom
      BevelOuter = bvNone
      Color = clBtnShadow
      ParentBackground = False
      TabOrder = 2
      Visible = False
      ExplicitTop = 791
      ExplicitWidth = 1093
      object imgAguard: TImage
        Left = 6
        Top = 7
        Width = 16
        Height = 16
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF610000001974455874536F667477617265004164
          6F626520496D616765526561647971C9653C0000000F744558745469746C6500
          47656F506F696E743B54A4DB6F000002E149444154785E75927D48DC751CC75F
          BFFBDD76BB3B710FA737CF875C7ADEEAD82EB1316DD2D33F52C9C6182C92ADE8
          8FFAA7D14828F7100CA6B99611ACC8A0489758DD95194342DCA2D02DB9128382
          852662B75D379D536F7ADEA3DEEF9303EF87C87AC387EFF79FF78BD7F7C31711
          0160F0FC3E0043677DB9F3C7B3959F0F343F16BCDA5C25FD4D55C1CB67F65E6C
          7B6D7719A0F63756022022F7061D00A8DF9FA8D8FFEB8567A2A16BCD12BFD925
          5AF8F2CAF9AD84AEBE23831FD4447DF5E50700752DC00000281FBFE276E6D973
          BD15CFBF6A71949560526761FE6F4CDA248E921CF61CAEB314D86D5FB7D4B95C
          A0F7F48BB1D8667EABD0B3C7AAA667884E8E32F0D937784F7EC440FB25625337
          30264214ED725B4BECE63701E37A806A52A9CD29DC0E893043DD3F33723DD072
          C437BE6D6C34D832FC831F598A93EBC8C6A4507B3F80414B8BCDA8A6906484C5
          F03C9746EEB60271EF9F339FC617E7D1C4884A0C34D902181445616574802413
          CBFF44A7A7D19251F29CF91C7DA2E018B0FDA5A70B8FDB4B8A209D2672678E58
          6239B06A60608D4A7A3692FA2E343A71BA6C771E0F577930675B1A7E29CE6ED8
          E2C86787C783A4EE121C9B24703B7E05D8086C00521983E59FFE0AB707AE4F44
          96924B6CD4E67095BBA83C7090B28A0A8C4B33C4E7A618FDE3DFD845FF541F60
          0136018A2222282B014C1F1E2E6DA8DE577AD65D9E0322201A0820C2D0B51B74
          F64D7CD53674E70BE036700B08679E2040EABD2BC14FCE9B8D87F2F2B31ED9BA
          15BD3C3D15A57F3078AB6378E637C00AA4811820FA4FEC7A7927C086D71F77D4
          F4BEF1E8F242EF2159ECDD2F0B3DB5D256E74CEFB46DEA00EA816A202BB3441D
          E07BD105A000D6779F7BA0D1DF542D919E67A5E7F82EA97930CB0F9C039E042C
          7A792DC07BC44962F86D56C9DB5A0F16F78DB43E2547DD9B6F028DC04399C5A1
          670D49D384EEF77D7CF942A9062C74FE3E7BCCDB3D16E8198F34011780712079
          6AAF4D00D61BAC8F021801DBAAB2CAFFE43F44AA4028728E642F000000004945
          4E44AE426082}
      end
      object imgLocali: TImage
        Left = 140
        Top = 7
        Width = 16
        Height = 16
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF6100000021744558745469746C65004170706C79
          3B4F4B3B436865636B3B426172733B526962626F6E3B6463C8680000037D4944
          4154785E4D8E7F4C94051CC63FEF7B77E02073EA92742577579B684891E62AB6
          C4526B6013696BC9DC5A0B33D0322DA716D3CA94A21A8E96E976AEB654688E40
          9B46B859CC249500E3F81588234EE0F875DC1DF7A3BB7BDFF7DBC16AEBD9F3D9
          BEFF3CCFF7C13555CB58A80140014CC5E5696BF638D24FBEF7EDF2D683550F7B
          0E5666B4969C5A5EBBEBCB652F0209803A116E6438F82377A66A60385007A0E4
          EFB2A5BC51B1B4AEF4EC5AB9D476583A87AA642C7055BA47CE4A43F727527131
          57F67D93DE54B0DFBE04308D867E9E290050725F4BBDB7F8E8B29EAA86B7C4E5
          BF203DDEE3D23E71585AC6F648E7E4C7D2E777C870A05E7E68DE277B4F668C6E
          DE6BCF00D4017F350A607EF548DAB99CECBC9CF4343BC3E1264CAA60C282AAA8
          288A028A30313E852DE509EE0C4D72EEF26967CD17FD4F0EDE0A064DF9BBEDEB
          6CD6C51F3C9DF5382EFF1540104014216E500C2ED6DDA4F67C3BEDB79BC9C95E
          C3E8F8784AD28288BBADC1D36C4E98652A7C2C7D2543816674430304C4885B07
          55E1CC99EBCC51D750F14E35DBCB32E91DF98DCCA5ABE8FCB36733E0500D3132
          EF9EAB108C7AE9ED1BA6B4AC969F2E39896A11CE5F68212529975D5B4A395A59
          C40B79CF6049D0489AAD81AA3C0A9854436741140FE148809AEA16CA8AAEA34C
          65F1E9E7F524EBEBD99A7F8053751FB2707118EB836642311F31C63174497C28
          6BEE6C55D3F48971DF2088C1A60D6BF9BAB6849D0547D8FD520D2F3F5F822FD8
          C7AFCEEF58B16A11FEC828313DC6A87F8868C488745C9D0C9AF5A8D2E51EF15B
          E72FD248B127E2F5FE8DE3FBFDEC28280755E1FDCFB691BF310B6FC48566C4C0
          30F08D458984B40E4057837EADAAA7CB87A0E2090EB2E491594C1A4DD45C2EC7
          79AB0E53B287C4399384A353718288A8F4767B09F8F4F380069094BBDD7AB3E4
          74869CB8B1428E5DCB90AAB60DB2E59055B2B621C72EAF93134D99723C8EE3F7
          9572A83A5336EEB439EF9A67990FA82A1071F7855EF9E35AC0D3EB0C010A9EF0
          00799B56F1EEDBAFC7BF87D00D411185BEEE30AD8DFE88AB2B501CF0C4FC5706
          DE34CC0D7F15E9AB53BF6A17784ED78C4AB72BF6803DDD82B6B013D5A420064C
          B875FABB628CB8A21DEEDBA1A2D6FAB11B8066480C7EE92F045000737CD6BCA7
          36DFB77F7D616A63EE769BCCB0C326CF6E4D6D5B5D70FF47C9732CF700164099
          CE4D3373FCA76CAB43052CFF62065440001D884E130F19FC4FFF00FE20CB5D5D
          F1FFF30000000049454E44AE426082}
      end
      object imgErro: TImage
        Left = 323
        Top = 7
        Width = 16
        Height = 16
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF6100000023744558745469746C650043616E6365
          6C3B53746F703B457869743B426172733B526962626F6E3B4C9696B200000388
          49444154785E1D906B4C536718C7FF3DBD40CB1A2E32B55C9D598B4CA675D8D1
          3836652E9B0359B67D5896653259E644A52571644474CB4CB6ECC23770C4449D
          D38D2885005E4683AB69C6168DA12384264EC8AAAC0C9149A1175ACEE9E939CF
          DE9EE7E477F2CBFFB924E720E6E943CC3B8895D12B00A0FEE3D08167A75A5BBA
          EEB71D9D081E6B4DA549FBDDA3CEEFDD1F3658016818AA98A71FD1915E202DE9
          80A19D741E3EF6E0F8A7FC7F673B6979E002C5BC43B4C2581EB8480BE7BA68E6
          441BEF3B72F03300990C8E1D5016554E7B55D6C1ED9543C6C2B5BB739FDF0259
          88838424E4240F10A0D2EAA0D26540AD37203CFE17C2C187A3EDBFDE7CF3DAD4
          748403A06EA8A8E830AC5FB33B7BAB1901B717AE23DFE1CEC5EBEC90A0E0EB71
          A3CFD981C0B017C6F252180BD6BD74BCFA856E003A0CBDFD966DF250532AD4FF
          038DB734D18557DF21CFB08F2E37B5D370ED5E72D7D52BEEF9654CE9F91C1FD3
          92EB0C4D3A0E4BE7F6ECD909CFDEFAD381AF4ED0A3D35FD399E272BA3F3D478F
          971234FD2044BDCE930AF798CF2FAED0DF5373CACCFCA92F2970B29DDCAFD7F5
          6B48945E918201C41738945A2D581C7461ADA3192AB50AD64F9A010272730CC8
          D4AA313BE44289D58CF85D3F2411504BB28D93845489145E041F9CC1863C09A1
          1BD7E1EFEA86240339463DB2B3F59025C0DFD98DD0C83594E6886C360831F408
          523265D208BC0021B20A35A782B8BC0429C2239A10D812417988007088B14C8A
          8421EA75A094044A8A48F20017E78587629220B370E69F2884EA3750F07E2324
          5946868E43A64EA3B8695F23F8EA7A046763EC780AC9640AF155FEB1269AE0BD
          91AC8CFDF910108E26F15A5B33788D1E860CF6CDE7CF225D45FB3F02A0C7CE36
          076E5CBD84825C3562A20E4B097E0CAD051B5FFCA97C9BE4ABAEA05B2FDBE9E6
          BE0F880F8568FCDB0E1AA9AA646C579C654AEF564D15FDB96333FDBCC94A8E75
          1B6A0140DF5168B9E42A7B86266AB6D2ED1A1BF559CAC853B58DFCB576F2D7D9
          D3AE64B777D96862D716EA2F2BA76F4CE62B008C1A00C2F9C57F9D8DA2C99212
          C5E72C85323699F320A77FD272040021DF9885F56BF2204457706F9EC74C4CF2
          F744169A012430DBF21E00A82B754F98BEC82EEEED7AF2291A306FA451EBD334
          6633938FF13BF341969D62BDCF738AAF6ED6EA4B006882CE77A14ABFD255D279
          9903606830E4EF28E274070C1C67D74255041044C25C9CE43B4149F8B16735F4
          1B8038DB9300E07F6924ECFB01D589CC0000000049454E44AE426082}
      end
      object lblAguard: TLabel
        Left = 29
        Top = 8
        Width = 92
        Height = 14
        Caption = 'Rota n'#227'o calculada'
      end
      object lblLocali: TLabel
        Left = 163
        Top = 8
        Width = 139
        Height = 14
        Caption = 'Rota calculada com sucesso'
      end
      object lblErro: TLabel
        Left = 347
        Top = 8
        Width = 125
        Height = 14
        Caption = 'Endere'#231'o n'#227'o encontrado'
      end
      object lblInfo: TLabel
        Left = 516
        Top = 8
        Width = 244
        Height = 14
        Caption = 'Possibilidade de endere'#231'o divergente do esperado'
      end
      object imgInfo: TImage
        Left = 492
        Top = 6
        Width = 16
        Height = 16
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
          0000001008060000001FF3FF610000000B744558745469746C6500496E666F3B
          6D122D860000032C49444154785E4D926B4C53671CC65F8480DB4CF8E632FCE6
          BE4D3F98F905E5BE95A86194A8518988554C87868240E45269D3721F728B054A
          3AA84E8358150D1034DC4B68579CAB502EA514B454B122975204BC06F3EC7D4F
          4EB79DE477F2CF7B9EDF7B9EF3E610F5ED6152DFEC6584D0CB87B285E24BF1E3
          F1E5D77CEA755C96F3D84C54379E10001C4C8C3F2B0D2CD70C6455698DF7AFDE
          1C7232AAB486D6324D5F767C92349065BCF91AEA928A06A357F6CD2B6D092FFF
          DD30F3506FC7D4F325ACAE7D6070335B2BD71866A4C57722F8463E958D7F1252
          5AA7E7E49CE2BB87ABB5C64DBB6309CB6B9FD06D594049CB144AEED9E8BC08F7
          C667D8E946D58DC6CD9C22DD11E694AA0708F7CD27CF2983F2ABBB3C73AF3D30
          D83DC869B6A1E2FE24E6573E61E323206F9A40E60D2BFA27DC6099FCEA6ECF71
          916C077F5EC42F5D7E4BF1E0D1286CAE0D4875D348D38EA1CDE4C2FA7B6090BE
          FD42AD19928631CA38C69D6FC1B217654D4AFE804940865C6776BC58465DA713
          997F58697014A7AE982094F5214EDE8FC4F2C710D78C405C3B8CDF5AA6E178B9
          8C74D9EDA7D4DD4A215FA5E436BBD769D76C5A3345338AA4AB6654DC99C4E3C9
          15B85781B2662B4E96999058F117CEAB9E826525B94D6EEA7E4DD84D9C71DDBD
          B6FE0189A543385162C2B1422334ED3358A4F2024579CD42DB0C40983780E30A
          03589639D4FD866B90905C376A7F368F4BEA611CCCD24390D10B615637E6DDE0
          C8559B1199DA899FD37B9046DBB12C73BC0DFC63E30B8A1B6EEAF170E81504E9
          BD884AEDC2B1CBBD985B0487B2D18290E40E44A474A1DD380796159EC82F612E
          F7F7EDFAF1979D474595AB36BB0BD9EABF1172BE03AD86377052D9390F0C59D7
          117CAE0D97544FC032474F57AEFEB0E7D0F7CCF5FEFBFEA1D1A9A2845F555FCC
          16071EE86791543488B0E4368489DB70A6408F96FE59B0670962D597D0688988
          399C7BE070917793AD7B43CEC408840A67555D0746C666B1F1EE23839BD99A20
          4EE1DCBB5F14C7CE8D39078E50F7A7582501F06F936F8376070547490A43A3B3
          3A236364AEC8983C179D7BF6454A0AB77FB76B87F7CD00A8AB2024FC908C841F
          FC0FFEBB0228DB28813CDBF8B52DFFCF47D0F91F6B8D1EEDA0C90E8300000000
          49454E44AE426082}
      end
      object lblIndicadores: TLabel
        Left = 971
        Top = 0
        Width = 3
        Height = 23
        Align = alRight
        Alignment = taRightJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 1090
        ExplicitHeight = 14
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 472
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
  end
  object dtsTmpDoc: TDataSource
    Left = 536
    Top = 16
  end
  object cxImageList: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 13632152
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C
          76E4120852AD06031B4D0000000E000000030000000000000000000000000000
          000301010519130A55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430
          C3FF2225AFFF211594FF140B58B20101051E0000000400000000000000020101
          03151C1270CD2522A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344
          D0FF394AD4FF2D3CCDFF2523A8FF1C1270D20101051D00000003000000091912
          5BA72A27AAFF2F41D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137
          BCFF2726ABFF3540C7FF2E40D0FF2927ACFF1A115EB10000000D08061C3D3129
          A2FD2C3CCCFF3842C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89
          CEFFEDEDF8FF5F5DBDFF3741C6FF2B3ACDFF3028A4FF0907204A1E185F9F373B
          BCFF3042D0FF2621A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2621A5FF2E3FCFFF343ABEFF201A66B0312A92E03542
          CBFF3446D1FF2C2FB5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2B2EB5FF3144D0FF3040CBFF312A95E53E37AEFA3648
          D0FF374AD3FF3A4ED5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3233B4FF384BD3FF3547D2FF3446D1FF3E37AEFA453FB4FA4557
          D7FF3B50D5FF4C5FDAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4242B7FF495DD8FF394CD4FF3F52D4FF443FB3FA403DA1DC5967
          DAFF5B6EDDFF4F4DBAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF4E4DB9FF576ADCFF5765D9FF403EA4E12E2D70987C85
          DDFF8798E8FF291D9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF291D9BFF8494E7FF7A81DDFF33317BAC111125356768
          D0FC9EACEDFF686FCEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68
          A8FFCBB5BCFF5646A1FF666DCCFF9BAAEEFF696CD0FD1212273F000000043B3B
          79977D84DFFFA5B6F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252
          BBFF2D219BFF6B72D0FFA2B3F0FF8086E0FF404183A700000008000000010303
          050C4E509DBC8087E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BAD
          EFFFA2B3F0FFACBCF3FF838AE3FF4F52A0C10303051100000002000000000000
          000100000005323464797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AE
          EFFF939DE9FF7479DAF83234647D000000080000000200000000000000000000
          000000000000000000031213232D40437D935D61B5D07378DFFC7378DFFC5D61
          B5D040437D951212223000000004000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000004000000130000000A0000
          0003000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000402040823173A6EDF010206650000
          0012000000040000000100000000000000000000000000000000000000000000
          000000000000000000000000000200000012163A6CB84095D7FF0D2552E20000
          0082000000280000000800000001000000000000000000000000000000000000
          000000000000000000010000000B0F2645823B83C7FF49B2F3FF2C6EB2FF091A
          37C7000000860000003F0000000A000000020000000000000000000000000000
          0000000000000000000507111E46326FB4FC52B6F2FF4DB6F4FF4BB2F2FF2458
          9CFD050C19A1000000710000003B0000000C0000000200000000000000000000
          00000000000200010214204D84D052A9E4FF52BAF5FF52B9F5FF51B8F5FF46A0
          DFFF173C73E50001026D0000004F0000002A0000000900000001000000000000
          000100000008112A487E468FCCFF5ABFF6FF59BEF6FF57BDF6FF57BCF6FF56BB
          F6FF377EC0FF0E2340A4000000440000002D0000001300000002000000000000
          000203080C232F6AABF267C2F4FF64C5F8FF78CDF8FF8AD5FBFF86D2F9FF6EC9
          F8FF5AB9F0FF285D9FF503060C4A000000200000000F00000002000000000000
          000615335285549CD4FF6CC9F9FF76C7F2FF529DD2FF3A87C4FF54A0D4FF82CE
          F4FF72CBF9FF4691CEFF132D4E92000000160000000700000001000000000000
          0009275E97D976C4EFFF70CDFAFF488FC9FF183857890000001F193B59904E96
          CDFF7CD1FAFF5FB7EBFF24568FD8000000100000000200000000000000000000
          000A3175B4FA8CDAFAFF7BD4FCFF2E6BB1FF0205081E00000008020509223174
          B7FF7FD4FAFF71CCF8FF2D6BAEF80000000C0000000000000000000000000000
          00082E6FA8E792D7F6FF88DBFDFF3D7CBDFF122D518900000011132E52894080
          C0FF7BD5FCFF7BCCF5FF2B66A3E80000000A0000000000000000000000000000
          00051F496E9C7BBBE2FF99E3FDFF7FCFF3FF417FBFFF2458A5FF417EBFFF79CC
          F4FF84DAFDFF6DB3E0FF1D446A9D000000060000000000000000000000000000
          0001060F17274487BDF4ADE6FAFFA7E8FEFF98E5FEFF92E0FEFF91E0FEFF98E4
          FEFF9FE2F9FF4081BBF4060E1629000000020000000000000000000000000000
          0000000000030F24354D458AC0F585C3E5FFABE2F7FFB9EFFEFFAAE2F7FF84C2
          E5FF4387BDF50F23334E00000003000000000000000000000000000000000000
          0000000000000000000207101724224F729C3376ACE33885C2FF3275ABE3224F
          739F070F17250000000300000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000002000000070000000C0000000F0000000F0000
          000C000000070000000200000000000000000000000000000000000000000000
          000000000001000000060403021A37211D8354322BB86F4339E56E4339E55633
          2CBB37211D830503021B00000006000000010000000000000000000000000000
          0001000000081C110F4B70453CE0B4958EFFDFD2CFFFF8F5F4FFF8F5F4FFDFD2
          CFFFB4958EFF70453CE01D12104F000000090000000100000000000000010000
          0006291A165F91655AFDDED0CCFFDFBFAEFFC28462FFB1673DFFB1653DFFBF82
          60FFDFBEACFFDED0CCFF91645AFD281A165F0000000600000001000000020A07
          062285594EF0E5D9D7FFCB9676FFB4683BFFE8C3B0FFFFEAE0FFFFE7E0FFF3D5
          C7FFB16338FFCA9274FFE5D9D7FF85584EF00A0706230000000200000006442E
          2885BFA29BFFE4C7B5FFBC7044FFB96D41FFBC7A55FFFFEAE3FFFFEAE3FFD09C
          80FFB4673BFFB96B3FFFE3C4B2FFBFA29BFF442E298600000006000000097A54
          4BD1E7DCD9FFCE9674FFBF7548FFBC7144FFBA754EFFFFEDE7FFFFEDE7FFCC96
          78FFB86D40FFBB7043FFCC916EFFE7DCD9FF7A544BD10000000A0000000A9469
          5EEDF7F3F2FFC7875DFFC68657FFC48355FFDBB299FFFFF0EAFFFFF0E9FFD09E
          80FFC07C4EFFC07B4EFFC37F56FFF7F3F2FF94695EED0000000B000000099A70
          63EDF8F4F3FFD5A176FFD1996BFFCC9162FFD6A98CFFEED6C8FFFFF0EDFFD5A6
          89FFC6895AFFC98C5DFFCD9268FFF8F4F3FF987064ED0000000A000000078664
          5ACCECE1DEFFE0B895FFD5A072FFD19B6CFFC68A5CFFBD7C4EFFBE7D4FFFC88B
          5DFFCF9365FFCE9465FFDAAC88FFECE2DEFF86645ACD0000000800000004523E
          387FD1B6AEFFF4E5D7FFDAA879FFD29D6EFFE5C6B1FFFFF6F3FFEAD0C2FFCC94
          69FFD29B6CFFD39B6CFFF1E0D3FFD1B6AEFF523E388000000004000000010D0A
          091AAD8679EFEFE6E3FFEFD9C3FFD7A677FFD6AD8CFFF9EEE7FFFFF8F4FFD4A4
          7DFFD5A172FFEDD4BEFFEFE6E3FFAE8679EF0D0A091B00000001000000000000
          0003362A2651C29B8DFCEBDED9FFF9F2ECFFE9D0BAFFD8AC86FFD7AB86FFEAD0
          BAFFFAF4EDFFEBDDD9FFC29A8DFC362A26520000000300000000000000000000
          0000000000032A211E3EA78477DBD9BFB5FFEBDDD8FFF7F2F0FFF7F2F0FFEBDD
          D8FFD9BFB5FFA78377DB2A211E3F000000030000000100000000000000000000
          000000000000000000020706050F58464075856B60ADAF8E7FE0AF8E7FE0876C
          62B057473F760706050F00000002000000000000000000000000000000000000
          0000000000000000000000000001000000020000000300000004000000040000
          0003000000020000000100000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000506060030373700000000000202020002020200000000000000000002
          0202000202020000000000303737000506060000000000000000000000000003
          0303000000000085999900869B9B000000000000000000030303000303030000
          00000000000000859A9A00859A9A000000000003030300000000000000000003
          0303000000000037404000DDFFFF00ADC8C8001E23230000000000000000001E
          232300ACC7C700DDFFFF00394242000000000003030300000000000000000001
          0101000000000007080800BCD9D900DDFFFF00D1F1F1004853530047525200D1
          F1F100DDFFFF00BDDADA00070808000000000001010100000000000000000000
          000000030404000000000081959500DDFFFF00D9FAFA00DBFDFD00DBFDFD00D9
          FAFA00DDFFFF0083979700000000000303030000000000000000000000000000
          0000000405050000000000353D3D00DDFFFF00DAFCFC00DAFCFC00DAFCFC00DA
          FCFC00DDFFFF00363E3E00000000000405050000000000000000000000000003
          030300020202000000000065747400DDFFFF00DCFEFE00DCFEFE00DCFEFE00DC
          FEFE00DDFFFF0065757500000000000202020003030300000000000202020000
          0000001215150099B1B100DDFFFF00DAFBFB00DCFEFE00DDFFFF00DDFFFF00DC
          FEFE00DAFBFB00DDFFFF009AB2B200121515000000000002020200000000004B
          565600D1F1F100DDFFFF00DCFEFE00DDFFFF00DCFEFE00DDFFFF00DDFFFF00DC
          FEFE00DDFFFF00DCFEFE00DDFFFF00D2F2F2004C585800000000004E5A5A00B3
          CECE00AFCACA00A4BDBD00A7C1C100A4BDBD00D1F1F100DDFFFF00DDFFFF00D1
          F1F100A5BEBE00A7C1C100A4BDBD00AFCACA00B3CECE004F5B5B000607070000
          00000000000000000000000303030000000000889D9D00DDFFFF00DDFFFF008A
          9F9F000000000003030300000000000000000000000000060707000000000001
          0101000202020002020200040505000000000045505000DDFFFF00DDFFFF0046
          5151000000000004050500020202000202020001010100000000000000000000
          000000000000000000000001010100000000000F111100CDEDED00CFEFEF0010
          1212000000000001010100000000000000000000000000000000000000000000
          00000000000000000000000000000003030300000000009FB8B800A1BABA0000
          0000000303030000000000000000000000000000000000000000000000000000
          00000000000000000000000000000003030300000000005A6868005B69690000
          0000000303030000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000101010000000000121515001316160000
          0000000101010000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000040404062828283700000000010101020101010200000000000000000101
          0102010101020000000028282837040404060000000000000000000000000202
          0203000000006F7070997072729B000000000000000002020203020202030000
          0000000000007071719A7071719A000000000202020300000000000000000202
          0203000000002E2F2F40B9BBBBFF919393C8191A1A230000000000000000191A
          1A23909292C7B9BBBBFF30303042000000000202020300000000000000000101
          010100000000060606089D9F9FD9B9BBBBFFAFB1B1F13C3D3D533B3C3C52AFB1
          B1F1B9BBBBFF9EA0A0DA06060608000000000101010100000000000000000000
          000003030304000000006C6D6D95B9BBBBFFB5B7B7FAB8BABAFDB8BABAFDB5B7
          B7FAB9BBBBFF6E6F6F9700000000020202030000000000000000000000000000
          000004040405000000002C2D2D3DB9BBBBFFB7B9B9FCB7B9B9FCB7B9B9FCB7B9
          B9FCB9BBBBFF2D2D2D3E00000000040404050000000000000000000000000202
          0203010101020000000054555574B9BBBBFFB8BABAFEB8BABAFEB8BABAFEB8BA
          BAFEB9BBBBFF5556567500000000010101020202020300000000010101020000
          00000F0F0F15808282B1B9BBBBFFB6B8B8FBB8BABAFEB9BBBBFFB9BBBBFFB8BA
          BAFEB6B8B8FBB9BBBBFF818383B20F0F0F150000000001010102000000003E3F
          3F56AFB1B1F1B9BBBBFFB8BABAFEB9BBBBFFB8BABAFEB9BBBBFFB9BBBBFFB8BA
          BAFEB9BBBBFFB8BABAFEB9BBBBFFB0B1B1F240414158000000004142425A9597
          97CE939494CA898B8BBD8C8E8EC1898B8BBDAFB1B1F1B9BBBBFFB9BBBBFFAFB1
          B1F18A8B8BBE8C8E8EC1898B8BBD939494CA959797CE4243435B050505070000
          0000000000000000000002020203000000007273739DB9BBBBFFB9BBBBFF7375
          759F000000000202020300000000000000000000000005050507000000000101
          0101010101020101010204040405000000003A3B3B50B9BBBBFFB9BBBBFF3B3B
          3B51000000000404040501010102010101020101010100000000000000000000
          0000000000000000000001010101000000000C0C0C11ACAEAEEDADAFAFEF0D0D
          0D12000000000101010100000000000000000000000000000000000000000000
          00000000000000000000000000000202020300000000858787B8878888BA0000
          0000020202030000000000000000000000000000000000000000000000000000
          000000000000000000000000000002020203000000004B4C4C684C4D4D690000
          0000020202030000000000000000000000000000000000000000000000000000
          000000000000000000000000000001010101000000000F0F0F15101010160000
          0000010101010000000000000000000000000000000000000000}
      end>
  end
end
