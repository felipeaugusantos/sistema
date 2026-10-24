inherited frmFatDadosFechamentoPedido: TfrmFatDadosFechamentoPedido
  Left = 333
  Top = 50
  Width = 1024
  Height = 973
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Dados do Pedido'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 973
  PixelsPerInch = 96
  TextHeight = 14
  object Shape1: TShape [0]
    AlignWithMargins = True
    Left = 511
    Top = 3
    Width = 1
    Height = 894
    Align = alLeft
    ExplicitLeft = 4
    ExplicitTop = 4
    ExplicitHeight = 745
  end
  inherited pnlBotoes: TPanel
    Top = 900
    Width = 1018
    ExplicitTop = 900
    ExplicitWidth = 1018
    DesignSize = (
      1018
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 325
      ExplicitLeft = 325
    end
  end
  inherited pnlStatus: TPanel
    Top = 928
    Width = 1018
    TabOrder = 4
    ExplicitTop = 928
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 830
      Width = 188
      ExplicitLeft = 830
      ExplicitWidth = 188
    end
    inherited pnlInfo: TPanel
      Width = 830
      ExplicitWidth = 830
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 5
    Visible = False
    ExplicitWidth = 0
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  object pnlConfirma: TPanel [4]
    Left = 0
    Top = 900
    Width = 1018
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    object btnCancelaDados: TBitBtnLocked
      Left = 903
      Top = 2
      Width = 113
      Height = 24
      Align = alRight
      Caption = '[ESC] Cancelar'
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
      TabOrder = 1
      OnClick = btnCancelaClick
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 101
      Height = 24
      Align = alLeft
      Caption = '[F10] Confirma'
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
      OnClick = btnConfirmaDadosClick
    end
    object btnMostraMargem: TBitBtnLocked
      Left = 103
      Top = 2
      Width = 103
      Height = 24
      Align = alLeft
      Caption = '[ F4 ] Margem/Lucro'
      TabOrder = 2
      OnClick = btnMostraMargemClick
    end
    object btnSimularVenda: TBitBtnLocked
      Left = 206
      Top = 2
      Width = 186
      Height = 24
      Align = alLeft
      Caption = '[F5] Visualizar Produtos / Impostos'
      TabOrder = 3
      OnClick = btnSimularVendaClick
    end
    object btnEspRascNF: TBitBtnLocked
      Left = 392
      Top = 2
      Width = 115
      Height = 24
      Align = alLeft
      Caption = '&Espelho Rasc. DANFE'
      TabOrder = 4
      Visible = False
      OnClick = btnEspRascNFClick
    end
    object btnTotalizadorEmp: TBitBtnLocked
      Left = 507
      Top = 2
      Width = 132
      Height = 24
      Align = alLeft
      Caption = '[ F6 ] Totalizador por Emp.'
      TabOrder = 5
      Visible = False
      OnClick = btnTotalizadorEmpClick
    end
  end
  object pnlLadoEsquerdo: TPanel [5]
    Left = 0
    Top = 0
    Width = 508
    Height = 900
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    inline fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame
      Left = 0
      Top = 234
      Width = 508
      Height = 206
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      ExplicitTop = 234
      ExplicitWidth = 508
      ExplicitHeight = 206
      inherited pnlFundo: TPanel
        Width = 508
        Height = 206
        ExplicitWidth = 508
        ExplicitHeight = 206
        inherited pnlTransportadora: TGroupBox
          Width = 504
          Height = 204
          Font.Pitch = fpVariable
          ExplicitWidth = 504
          ExplicitHeight = 204
          inherited pnlTransportadoraFrete: TPanel
            Width = 500
            ExplicitWidth = 500
            inherited lblValFre: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblQtdTra: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblEspVol: TLabel
              Font.Pitch = fpVariable
            end
            inherited btnCalcVolume: TSpeedButton
              Font.Pitch = fpVariable
            end
            inherited btnCalcFreSug: TSpeedButton
              Left = 205
              Font.Pitch = fpVariable
              ExplicitLeft = 205
            end
            inherited Label2: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblValFreCot: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtValFre: TEditFocus
              Width = 93
              Font.Pitch = fpVariable
              MaxLength = 10
              OnExit = fraTransportadoraedtValFreExit
              TamCampo = 10
              ExplicitWidth = 93
            end
            inherited edtQtdTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtEspVol: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited btnCalcularFrete: TBitBtnLocked
              Left = 233
              Font.Pitch = fpVariable
              OnClick = fraTransportadorabtnCalcularFreteClick
              ExplicitLeft = 233
            end
            inherited edtCodTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtNomTra: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtValFreCot: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited pnlTransportadoraFreteAux: TPanel
              Width = 500
              ExplicitWidth = 500
              inherited Label23: TLabel
                Font.Pitch = fpVariable
              end
              inherited Label4: TLabel
                Font.Pitch = fpVariable
              end
              inherited Label7: TLabel
                Font.Pitch = fpVariable
              end
              inherited cmbTipFre: TComboBoxFocus
                Font.Pitch = fpVariable
              end
              inherited edtDesAce: TEditFocus
                Font.Pitch = fpVariable
              end
              inherited edtNumReg: TEditFocus
                Font.Pitch = fpVariable
              end
            end
            inherited pnlVolumeSepExc: TPanel
              Width = 500
              ExplicitWidth = 500
              inherited lblQtdTraSepExc: TLabel
                Font.Pitch = fpVariable
              end
              inherited lblQtdTraSepNExc: TLabel
                Font.Pitch = fpVariable
              end
              inherited edtQtdTraSepExc: TEditFocus
                Font.Pitch = fpVariable
              end
              inherited edtQtdTraSepNExc: TEditFocus
                Font.Pitch = fpVariable
              end
            end
          end
          inherited pnlTraRedesp: TPanel
            Top = 130
            Width = 500
            Font.Pitch = fpVariable
            ExplicitTop = 130
            ExplicitWidth = 500
          end
          inherited pnlPeso: TPanel
            Top = 176
            Width = 500
            Font.Pitch = fpVariable
            ExplicitTop = 176
            ExplicitWidth = 500
          end
          inherited pnlRota: TPanel
            Top = 153
            Width = 500
            ExplicitTop = 153
            ExplicitWidth = 500
            inherited lblRota: TLabel
              Font.Pitch = fpVariable
            end
          end
        end
      end
    end
    object pnlCondicaoPagamento: TcxGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 0
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Pagamento:'
      Ctl3D = True
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnExit = pnlCondicaoPagamentoExit
      Height = 118
      Width = 504
      inline fraPagamento: TfraDigCndPagamento
        Left = 2
        Top = 18
        Width = 500
        Height = 98
        VertScrollBar.Range = 45
        Align = alClient
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 18
        ExplicitWidth = 500
        ExplicitHeight = 98
        inherited pnlFundo: TPanel
          Width = 500
          Height = 98
          BevelInner = bvNone
          BevelOuter = bvNone
          ExplicitWidth = 500
          ExplicitHeight = 98
          inherited pnlCndPag: TPanel
            Left = 0
            Top = 24
            Width = 500
            ExplicitLeft = 0
            ExplicitTop = 24
            ExplicitWidth = 500
            inherited lblObs: TLabel
              Font.Pitch = fpVariable
            end
            inherited pnlTrocarCondPagamento: TPanel
              inherited lblTrocarCondPagamento: TLabel
                Font.Pitch = fpVariable
              end
            end
          end
          inherited pnlForPag: TPanel
            Left = 0
            Top = 59
            Width = 500
            ExplicitLeft = 0
            ExplicitTop = 59
            ExplicitWidth = 500
          end
          inherited pnlDados: TPanel
            Left = 0
            Top = 106
            Width = 500
            ExplicitLeft = 0
            ExplicitTop = 106
            ExplicitWidth = 500
            inherited dbgDupAgru: TDBGridCitel
              TitleFont.Pitch = fpVariable
            end
          end
          inherited pnlChecks: TPanel
            Left = 0
            Top = 83
            Width = 500
            Height = 23
            ExplicitLeft = 0
            ExplicitTop = 83
            ExplicitWidth = 500
            ExplicitHeight = 23
            inherited lblPagamentoPix: TLabel
              Font.Pitch = fpVariable
            end
            inherited chkZerTax: TCheckBox
              OnClick = fraPagamentochkZerTaxClick
            end
          end
          inherited pnlPrevisao: TPanel
            Left = 0
            Top = 0
            Width = 500
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 500
          end
        end
      end
    end
    object pnlFaseObra: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 440
      Width = 504
      Height = 46
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Fase da Obra:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      inline fraFaseObra: TfraSelFaseObraFrame
        Left = 2
        Top = 15
        Width = 500
        Height = 29
        VertScrollBar.Range = 45
        VertScrollBar.Visible = False
        Align = alClient
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 500
        ExplicitHeight = 29
        inherited pnlFundo: TPanel
          Width = 500
          ExplicitWidth = 500
          ExplicitHeight = 45
          inherited Label1: TLabel
            Top = 6
            Height = 14
            ExplicitTop = 6
            ExplicitHeight = 14
          end
          inherited edtCodFas: TEditFocus
            Top = 1
            Height = 22
            ExplicitTop = 1
            ExplicitHeight = 22
          end
          inherited edtDescri: TEditFocus
            Top = 1
            Height = 22
            ExplicitTop = 1
            ExplicitHeight = 22
          end
        end
      end
    end
    object pnlProfissional: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 717
      Width = 504
      Height = 58
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Escolha do Profissional:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      inline fraDigProfissional: TfraFatDigProfissionalFrame
        Left = 2
        Top = 15
        Width = 500
        Height = 41
        VertScrollBar.Range = 45
        VertScrollBar.Visible = False
        Align = alClient
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 500
        ExplicitHeight = 41
        inherited pnlFundo: TPanel
          Width = 500
          Height = 45
          ExplicitWidth = 500
          ExplicitHeight = 45
          inherited lblCliDiv: TLabel
            Top = 33
            Width = 500
            Height = 12
            Font.Height = -9
            ExplicitTop = 33
            ExplicitWidth = 328
            ExplicitHeight = 12
          end
          inherited edtCodPro: TEditFocus
            OnEnter = fraDigProfissionaledtCodProEnter
            OnExit = fraDigProfissionaledtCodProExit
          end
          inherited edtDesPro: TEditFocus
            Width = 306
            ExplicitWidth = 306
          end
        end
      end
    end
    object pnlProfissionalVarios: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 777
      Width = 504
      Height = 135
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Escolha os Profissionais:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      inline fraDigProfissionalVarios: TfraFatDigProfissionalVariosFrame
        Left = 2
        Top = 15
        Width = 500
        Height = 118
        VertScrollBar.Range = 45
        VertScrollBar.Visible = False
        Align = alClient
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 15
        ExplicitWidth = 500
        ExplicitHeight = 118
        inherited pnlFundo: TPanel
          Width = 500
          Height = 118
          BevelInner = bvNone
          BevelOuter = bvNone
          ExplicitWidth = 500
          ExplicitHeight = 118
          inherited lblNomPro: TLabel
            Top = 6
            ExplicitTop = 6
          end
          inherited lblCliDiv: TLabel
            Left = 87
            Top = 24
            Align = alNone
            Layout = tlCenter
            ExplicitLeft = 87
            ExplicitTop = 24
          end
          inherited edtCodPro: TEditFocus
            Top = 2
            OnEnter = fraDigProfissionalVariosedtCodProEnter
            OnExit = fraDigProfissionalVariosedtCodProExit
            ExplicitTop = 2
          end
          inherited edtDesPro: TEditFocus
            Top = 2
            Width = 229
            ExplicitTop = 2
            ExplicitWidth = 229
          end
          inherited btnAdicionaItem: TBitBtnLocked
            Left = 410
            Top = 1
            ExplicitLeft = 410
            ExplicitTop = 1
          end
          inherited dbgItens: TDBGridCitel
            AlignWithMargins = True
            Left = 3
            Top = 38
            Width = 494
            Height = 77
            TitleFont.Pitch = fpVariable
            Columns = <
              item
                Expanded = False
                FieldName = 'DIV_CODDIV'
                Title.Caption = 'C'#243'digo'
                Width = 55
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DIV_NOMDIV'
                Title.Caption = 'Nome do Profissional'
                Width = 198
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ATI_CODATI'
                Title.Caption = 'C'#243'd. Ativ.'
                Width = 55
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ATI_DESATI'
                Title.Caption = 'Descri'#231#227'o da Atividade'
                Width = 146
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'COM_VRCOMI'
                Title.Alignment = taRightJustify
                Title.Caption = 'Comiss'#227'o'
                Visible = True
              end>
          end
        end
      end
    end
    object pnlEntrega: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 123
      Width = 502
      Height = 108
      Align = alTop
      Caption = 'Local de Entrega:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlDescricaoEndereco: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 45
        Width = 492
        Height = 42
        Align = alBottom
        BevelInner = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object lblDescricaoEndereco: TLabel
          Left = 2
          Top = 2
          Width = 488
          Height = 38
          Align = alClient
          Alignment = taCenter
          Caption = 'Endere'#231'o de Entrega: '
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 124
          ExplicitHeight = 15
        end
      end
      object pnlCPFCNPJCliente: TPanel
        Left = 2
        Top = 90
        Width = 498
        Height = 16
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        Visible = False
        object lblCPFCNPJCliente: TLabel
          Left = 4
          Top = 0
          Width = 149
          Height = 15
          Caption = 'CNPJ/CPF: 000.000.000-00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object btnAlterarEntrega: TBitBtnLocked
        Left = 288
        Top = 13
        Width = 198
        Height = 25
        Caption = '[F1] Alterar endere'#231'o de entrega'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000E0000000F0000000F0000000F0000000F0000000F0000000F0000000F0000
          00100000001000000010000000100000000F0000000A000000027B5A50C0AB7D
          6EFFAB7C6CFFA97B6BFFA97A6BFFA8796AFFA77868FFA67768FFA57667FFA575
          66FFA47465FFA37464FFA37363FFA27262FF755246C100000009B18576FFF9F1
          EDFFF8F0ECFFF9F1EDFFF8F0ECFFF8F1ECFFF8F0EDFFF8F0ECFFF8F0ECFFF8F0
          ECFFF8EFECFFF8F0ECFFF8F0ECFFF8F0ECFFAF8273FF0000000EB38779FFF8F1
          EDFFE0B787FFE0B886FFDFB686FFDEB685FFE9CDA5FFEAD0AAFFEBCFA9FFEACF
          A9FFDFB786FFDEB582FFDEB482FFF8F0ECFFB18475FF0000000EB4897BFFFAF2
          EFFFE0BA8AFFE0BA89FFE1B988FFE0BA89FFEED8B6FF709E7AFF599471FFE1D3
          B0FFEAD0A9FFDFB785FFDFB785FFF8F2EEFFB28677FF0000000DB68C7EFFFAF3
          F1FFE0BA8AFFE0BA89FFE1B988FFE2BF91FFEFD9B7FF328662FF2BB080FF6099
          76FFEFD9B7FFE0B987FFDFB785FFF9F3EFFFB4887AFF0000000DB88F81FFFAF5
          F2FFE2BD8DFFE1BD8DFFE2BC8CFFEBD2ADFFD0CDACFF2F936DFF27C18AFF2B89
          64FFE6D6B5FFE2BE8FFFE0B988FFFAF3F1FFB68B7DFF0000000CBA9284FFFBF7
          F4FFE7C79DFFF0DCBAFFF0DBBAFFF1DCBCFF67A583FF2CB786FF26C48BFF2C93
          6CFFD4D0AFFFEBD3AEFFE1BB8CFFFBF5F2FFB88E80FF0000000BBC9587FFFBF7
          F5FFF0DCBBFFBBCBA9FF3A9B77FF3B9A76FF2DBB8BFF2ACA94FF2ACA91FF2FBA
          8BFF65A683FFEDD5B2FFE3BD8EFFFBF6F4FFB99183FF0000000ABF988AFFFDF9
          F7FFF0DEBCFF48A682FF45D4A9FF31D09EFF2ED09CFF2ECF99FF35D29EFF40C1
          97FF5FA885FFEDD7B3FFE3C091FFFCF8F5FFBB9386FF0000000AC19B8EFFFDFA
          FAFFF1DFBEFF4CAD89FF53DAB4FF42DAACFF40D9ABFF4EDCB3FF49C8A2FF75B5
          92FFF2E0C0FFEFD9B6FFE5C496FFFCF9F7FFBE9789FF00000009C29E91FFFDFC
          FBFFF2E0BFFFB2D1AFFF4AC19DFF60E3BFFF49C29DFF41B590FF41B28EFFB9D0
          AEFFEED8B3FFE6C799FFE6C799FFFDFBF9FFC09A8CFF00000008C5A195FFFFFD
          FDFFEDD5AEFFF3E2C4FFA4CFADFF44B490FFA8CDADFFCED8B8FFD1D9B8FFF3E3
          C3FFEBD1A8FFE7CA9CFFE7C99CFFFDFCFBFFC19D90FF00000008C7A498FFFEFE
          FEFFEACFA4FFEED8B3FFF3E4C5FFF4E4C5FFF4E3C4FFEDD7B0FFEBD1A8FFEAD0
          A8FFE9CCA0FFE9CCA0FFE8CB9FFFFEFDFDFFC4A093FF00000007C9A79AFFFFFF
          FFFFFEFFFFFFFFFFFEFFFFFEFFFFFEFEFEFFFEFFFEFFFEFEFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFC6A396FF000000069E867CC0D4B4
          A7FFD4B4A7FFD4B4A7FFD3B3A6FFD3B3A6FFD3B2A6FFD2B2A5FFD2B2A4FFD1B1
          A4FFD1B0A3FFD0B0A3FFD0AFA2FFCFAEA1FF9A8178C100000004}
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnAlterarEntregaClick
      end
      object chkLocalDiferente: TCheckBox
        Left = 5
        Top = 22
        Width = 233
        Height = 18
        TabStop = False
        Caption = 'Local de entrega diferente do destinat'#225'rio'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkLocalDiferenteClick
      end
    end
    object pnlTotalDocumento: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 917
      Width = 502
      Height = 186
      Align = alTop
      Caption = 'Total do documento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object pnlInformacoesTotalVenda: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 492
        Height = 163
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object lblTitProdutos: TLabel
          Left = 23
          Top = 2
          Width = 161
          Height = 16
          Caption = '    Total dos Produtos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label82: TLabel
          Left = 23
          Top = 41
          Width = 70
          Height = 15
          Caption = '(+) Frete:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label83: TLabel
          Left = 23
          Top = 28
          Width = 154
          Height = 15
          Caption = '(+) Despesa Acess'#243'ria:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label84: TLabel
          Left = 23
          Top = 55
          Width = 56
          Height = 15
          Caption = '(+) IPI:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label86: TLabel
          Left = 23
          Top = 68
          Width = 49
          Height = 15
          Caption = '(+) ST:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitTotalComImpostos: TLabel
          Left = 23
          Top = 144
          Width = 161
          Height = 16
          Caption = '(=) Total com impostos:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblTotalProdutos: TLabel
          Left = 371
          Top = 2
          Width = 28
          Height = 16
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblFrete: TLabel
          Left = 371
          Top = 41
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDespesaAcessoria: TLabel
          Left = 371
          Top = 28
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblIPI: TLabel
          Left = 371
          Top = 55
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblST: TLabel
          Left = 371
          Top = 68
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTotalComImpostos: TLabel
          Left = 371
          Top = 144
          Width = 28
          Height = 16
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 23
          Top = 81
          Width = 77
          Height = 15
          Caption = '(+) FCP/ST:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFCPST: TLabel
          Left = 371
          Top = 81
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitDescontoEspecial: TLabel
          Left = 23
          Top = 15
          Width = 154
          Height = 15
          Caption = '(-) Desconto Especial:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescontoEspecial: TLabel
          Left = 371
          Top = 15
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitCreditoCliente: TLabel
          Left = 23
          Top = 133
          Width = 84
          Height = 15
          Caption = '(-) CR'#201'DITO:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblCreditoCliente: TLabel
          Left = 371
          Top = 133
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitCBS: TLabel
          Left = 23
          Top = 94
          Width = 56
          Height = 15
          Caption = '(+) CBS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblCBS: TLabel
          Left = 371
          Top = 94
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitIBS: TLabel
          Left = 23
          Top = 107
          Width = 56
          Height = 15
          Caption = '(+) IBS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblIBS: TLabel
          Left = 371
          Top = 107
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblTitIS: TLabel
          Left = 23
          Top = 120
          Width = 49
          Height = 15
          Caption = '(+) IS:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblIS: TLabel
          Left = 371
          Top = 120
          Width = 28
          Height = 15
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    inline fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame
      Left = 0
      Top = 488
      Width = 508
      Height = 229
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 4
      ExplicitTop = 488
      ExplicitWidth = 508
      inherited pnlFundo: TPanel
        Width = 508
        ExplicitWidth = 508
        inherited pnlInvoice: TGroupBox
          Width = 504
          Font.Pitch = fpVariable
          ExplicitWidth = 504
          inherited lblIncoterms: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblPortoDestino: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblPortoEmbarque: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblAeroporto: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblTarifa: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblSeguro: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblFrete: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblWorks: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblNotify: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblContainer: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblPacking: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtCodTer: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtDesTer: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtPorDes: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtDesPor: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtPorEmb: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtDesEmb: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtAeropo: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtDesAer: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtTarifa: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtSeguro: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtFrete: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtCodWor: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtNomWor: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtNotify: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtTipCont: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtPackin: TEditFocus
            Font.Pitch = fpVariable
          end
        end
      end
    end
  end
  object pnlLadoDireito: TPanel [6]
    Left = 521
    Top = 0
    Width = 497
    Height = 900
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    inline fraDadosPedido: TfraDadosFechamentoPedidoFrame
      Left = 0
      Top = 307
      Width = 497
      Height = 384
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      ExplicitTop = 307
      ExplicitHeight = 384
      inherited pnlFundo: TPanel
        Height = 384
        ExplicitHeight = 384
        inherited pnlBombeamento: TGroupBox
          Font.Pitch = fpVariable
          inherited lblTotalBombeamento: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblQtdBombeamento: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblPrecoBombeamento: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtTotBom: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtQtdBom: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtPrcBom: TEditFocus
            Font.Pitch = fpVariable
          end
        end
        inherited pnlOutrasInformacoes: TGroupBox
          Font.Pitch = fpVariable
          inherited lblValidade: TLabel
            Font.Pitch = fpVariable
          end
          inherited chkPedExp: TCheckBox
            Top = 45
            Font.Pitch = fpVariable
            ExplicitTop = 45
          end
          inherited btnPedCmp: TBitBtnLocked
            Font.Pitch = fpVariable
          end
          inherited pnlGerPen: TPanel
            Font.Pitch = fpVariable
          end
          inherited pnlContato: TPanel
            Font.Pitch = fpVariable
          end
          inherited pnlTipAte: TPanel
            Font.Pitch = fpVariable
          end
          inherited pnlPorPed: TPanel
            Font.Pitch = fpVariable
          end
          inherited pnlOpcoesPV: TPanel
            Font.Pitch = fpVariable
          end
          inherited chkAgrIte: TCheckBox
            Font.Pitch = fpVariable
          end
          inherited pnlProjeto: TPanel
            inherited Label12: TLabel
              Font.Pitch = fpVariable
            end
          end
          inherited pnlTipOpe: TPanel
            Font.Pitch = fpVariable
            inherited lblTipOpe: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtTipOpe: TEditFocus
              Font.Pitch = fpVariable
              OnExit = fraDadosPedidoedtTipOpeExit
            end
          end
          inherited pnlCategoria: TPanel
            Font.Pitch = fpVariable
            inherited lblCategoria: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesCat: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlEventos: TPanel
            Font.Pitch = fpVariable
            inherited lblEventos: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesEvento: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlEmpFat: TPanel
            Font.Pitch = fpVariable
            inherited lblEmpFat: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesEmpFat: TEditFocus
              Font.Pitch = fpVariable
            end
          end
        end
        inherited pnlTipoDeFaturamento: TGroupBox
          Font.Pitch = fpVariable
          inherited lblTipFat: TColorLabel
            Font.Pitch = fpVariable
          end
          inherited Label11: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtTipFat: TEditFocus
            Font.Pitch = fpVariable
          end
        end
        inherited pnlFinalizacaoDoPedido: TGroupBox
          Font.Pitch = fpVariable
          inherited lblFinPed: TLabel
            Height = 24
          end
          inherited pnlFinaliza: TPanel
            Font.Pitch = fpVariable
          end
        end
        inherited gpbRetornarContatoCliente: TGroupBox
          Font.Pitch = fpVariable
          inherited Panel2: TPanel
            Font.Pitch = fpVariable
          end
        end
      end
    end
    inline fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame
      Left = 0
      Top = 0
      Width = 497
      Height = 215
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      inherited pnlFundo: TPanel
        inherited pnlObservacoes: TGroupBox
          Font.Pitch = fpVariable
          inherited Label1: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblMenExp: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtMens01: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMens02: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMenExp: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMenEx2: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMenEx3: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMenEx4: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMens03: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMens04: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtMens05: TEditFocus
            Font.Pitch = fpVariable
          end
        end
      end
    end
    inline fraDescFinanBoletoAdto: TfraDescontoFinanceiroBoletoAdiantamentoFrame
      Left = 0
      Top = 215
      Width = 497
      Height = 92
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      ExplicitTop = 215
      ExplicitHeight = 92
      inherited pnlFundo: TPanel
        Height = 92
        ExplicitHeight = 92
        inherited pnlDescontoFinanceiro_BoletoAdiantamento: TPanel
          Height = 92
          ExplicitHeight = 92
          inherited pnlDescontoFinanceiro: TGroupBox
            Height = 92
            Font.Pitch = fpVariable
            ExplicitHeight = 92
            inherited Label3: TLabel
              Font.Pitch = fpVariable
            end
            inherited ColorLabel4: TColorLabel
              Font.Pitch = fpVariable
            end
            inherited Label8: TLabel
              Font.Pitch = fpVariable
            end
            inherited lblPerDes: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesFin: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtTipFin: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlBoletoDeAdiantamento: TGroupBox
            Width = 240
            Height = 92
            Font.Pitch = fpVariable
            ExplicitWidth = 240
            ExplicitHeight = 92
            inherited Label7: TLabel
              Font.Pitch = fpVariable
            end
            inherited Label10: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtBolAdt: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited edtValRes: TEditFocus
              Font.Pitch = fpVariable
            end
            inherited chkBolVen: TCheckBox
              Font.Pitch = fpVariable
              ParentCtl3D = False
              OnClick = fraDescFinanBoletoAdtochkBolVenClick
            end
          end
        end
      end
    end
    inline fraFatorParaFaturamento: TfraFatorParaFaturamentoFrame
      Left = 0
      Top = 691
      Width = 497
      Height = 68
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 3
      ExplicitTop = 691
      ExplicitHeight = 68
      inherited pnlFundo: TPanel
        Height = 68
        ExplicitHeight = 68
        inherited pnlFatorParaFaturamento: TGroupBox
          Font.Pitch = fpVariable
          inherited lblFatCal: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblTipoFator: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblCodPor: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtFatCal: TEditFocus
            Font.Pitch = fpVariable
            OnChange = nil
          end
          inherited edtCodPor: TEditFocus
            Font.Pitch = fpVariable
            OnKeyPress = nil
          end
          inherited edtNomPor: TEditFocus
            Font.Pitch = fpVariable
          end
        end
      end
    end
    inline fraLiberacaoPedido: TfraLiberacaoPedidoFrame
      Left = 0
      Top = 759
      Width = 497
      Height = 59
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 4
      ExplicitTop = 759
      ExplicitHeight = 59
      inherited pnlFundo: TPanel
        Height = 59
        ExplicitHeight = 59
        inherited pnlLiberacaoPedido: TGroupBox
          Font.Pitch = fpVariable
          inherited lblMotLib: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtMotLib: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited chkAgdLib: TCheckBox
            Font.Pitch = fpVariable
          end
        end
      end
    end
    inline fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame
      Left = 0
      Top = 818
      Width = 497
      Height = 27
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 5
      ExplicitTop = 818
    end
    inline fraClienteContaOrdemFrame: TfraClienteContaOrdemFrame
      Left = 0
      Top = 845
      Width = 497
      Height = 55
      Align = alClient
      TabOrder = 6
      Visible = False
      ExplicitTop = 845
      ExplicitWidth = 497
      ExplicitHeight = 55
      inherited pnlFundo: TPanel
        Width = 497
        Height = 55
        ExplicitWidth = 497
        ExplicitHeight = 55
        inherited pnlClienteContaOrdem: TGroupBox
          Width = 491
          ExplicitWidth = 491
        end
      end
    end
  end
  object pnlImpressao: TPanel [7]
    Left = 981
    Top = 812
    Width = 33
    Height = 83
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object lblImpressao: TcxLabel
      Left = 0
      Top = 0
      Align = alClient
      AutoSize = False
      Caption = 'Impress'#227'o'
      ParentColor = False
      Style.BorderStyle = ebsFlat
      Style.Color = clBtnFace
      Style.Edges = [bLeft, bTop, bRight, bBottom]
      Style.HotTrack = False
      Style.LookAndFeel.NativeStyle = True
      Style.Shadow = False
      StyleDisabled.LookAndFeel.NativeStyle = True
      StyleFocused.LookAndFeel.NativeStyle = True
      StyleHot.LookAndFeel.NativeStyle = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.Angle = 270
      Properties.Orientation = cxoLeft
      OnClick = lblImpressaoClick
      Height = 83
      Width = 33
      AnchorX = 17
      AnchorY = 42
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 576
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 648
    Top = 56
  end
  object cxsGrid: TcxStyleRepository
    Left = 576
    Top = 16
    PixelsPerInch = 96
    object cxsPadrao: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
  end
end
