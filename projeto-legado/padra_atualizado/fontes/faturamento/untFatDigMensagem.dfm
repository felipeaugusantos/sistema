inherited frmFatDigMensagem: TfrmFatDigMensagem
  Left = 333
  Top = 50
  Width = 548
  Height = 1390
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Dados do Pedido'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitTop = -806
  ExplicitWidth = 548
  ExplicitHeight = 1390
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 1289
    Width = 542
    TabOrder = 9
    ExplicitTop = 1298
    ExplicitWidth = 606
    DesignSize = (
      542
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 538
      ExplicitWidth = 602
    end
    inherited btnSair: TBitBtnLocked
      Left = 325
      ExplicitLeft = 325
    end
  end
  inherited pnlStatus: TPanel
    Top = 1289
    Width = 542
    TabOrder = 11
    ExplicitTop = 1326
    ExplicitWidth = 606
    inherited pnlNomeForm: TPanel
      Left = 354
      Width = 188
      ExplicitLeft = 418
      ExplicitWidth = 188
    end
    inherited pnlInfo: TPanel
      Width = 354
      ExplicitWidth = 418
    end
  end
  inherited pgcDados: TPageControl
    Width = 0
    Height = 0
    Align = alNone
    TabOrder = 8
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
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 1305
    Width = 542
    Height = 56
    Align = alBottom
    BevelInner = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 10
    ExplicitTop = 1286
    ExplicitWidth = 606
    object btnCancelaDados: TBitBtnLocked
      Left = 439
      Top = 2
      Width = 101
      Height = 52
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
      TabOrder = 5
      OnClick = btnCancelaClick
      ExplicitLeft = 503
      ExplicitHeight = 24
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 132
      Height = 24
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
      Left = 133
      Top = 2
      Width = 132
      Height = 24
      Caption = '[ F4 ] Margem/Lucro'
      TabOrder = 1
      OnClick = btnMostraMargemClick
    end
    object btnSimularVenda: TBitBtnLocked
      Left = 264
      Top = 2
      Width = 175
      Height = 24
      Caption = '[F5] Visualizar Produtos / Impostos'
      TabOrder = 2
      OnClick = btnSimularVendaClick
    end
    object btnEspRascNF: TBitBtnLocked
      Left = 2
      Top = 26
      Width = 132
      Height = 24
      Caption = '&Espelho Rasc. DANFE'
      TabOrder = 3
      Visible = False
      OnClick = btnEspRascNFClick
    end
    object btnTotalizadorEmp: TBitBtnLocked
      Left = 133
      Top = 26
      Width = 132
      Height = 24
      Caption = '[ F6 ] Totalizador por Emp.'
      TabOrder = 4
      Visible = False
      OnClick = btnTotalizadorEmpClick
    end
  end
  inline fraDadosPedido: TfraDadosFechamentoPedidoFrame [4]
    Left = 0
    Top = 704
    Width = 542
    Height = 384
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    Ctl3D = True
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 3
    ExplicitTop = 704
    ExplicitWidth = 606
    ExplicitHeight = 384
    inherited pnlFundo: TPanel
      Width = 542
      Height = 384
      ExplicitWidth = 606
      ExplicitHeight = 384
      inherited pnlBombeamento: TGroupBox
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
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
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        inherited lblValidade: TLabel
          Font.Pitch = fpVariable
        end
        inherited chkPedExp: TCheckBox
          Font.Pitch = fpVariable
        end
        inherited btnPedCmp: TBitBtnLocked
          Font.Pitch = fpVariable
        end
        inherited pnlGerPen: TPanel
          Font.Pitch = fpVariable
        end
        inherited pnlContato: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
        end
        inherited pnlTipAte: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
        end
        inherited pnlPorPed: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
        end
        inherited pnlOpcoesPV: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
        end
        inherited chkAgrIte: TCheckBox
          Font.Pitch = fpVariable
        end
        inherited pnlProjeto: TPanel
          Width = 534
          ExplicitWidth = 598
          inherited Label12: TLabel
            Font.Pitch = fpVariable
          end
        end
        inherited pnlTipOpe: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
          inherited lblTipOpe: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtTipOpe: TEditFocus
            Left = 105
            Top = 0
            Font.Pitch = fpVariable
            OnExit = fraDadosPedidoedtTipOpeExit
            ExplicitLeft = 105
            ExplicitTop = 0
          end
          inherited pnlClienteTipoOperacao: TPanel
            Width = 534
            ExplicitWidth = 598
          end
        end
        inherited pnlCategoria: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
          inherited lblCategoria: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtDesCat: TEditFocus
            Font.Pitch = fpVariable
          end
        end
        inherited pnlEventos: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
          inherited lblEventos: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtDesEvento: TEditFocus
            Font.Pitch = fpVariable
          end
        end
        inherited pnlEmpFat: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
          inherited lblEmpFat: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtDesEmpFat: TEditFocus
            Font.Pitch = fpVariable
          end
        end
      end
      inherited pnlTipoDeFaturamento: TGroupBox
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
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
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        inherited lblFinPed: TLabel
          Height = 21
        end
        inherited pnlFinaliza: TPanel
          Width = 281
          Font.Pitch = fpVariable
          ExplicitWidth = 345
        end
      end
      inherited gpbRetornarContatoCliente: TGroupBox
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        inherited Panel2: TPanel
          Width = 534
          Font.Pitch = fpVariable
          ExplicitWidth = 598
        end
      end
    end
  end
  inline fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame [5]
    Left = 0
    Top = 0
    Width = 542
    Height = 165
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    ExplicitWidth = 606
    ExplicitHeight = 165
    inherited pnlFundo: TPanel
      Width = 542
      Height = 165
      ExplicitWidth = 606
      ExplicitHeight = 165
      inherited pnlObservacoes: TGroupBox
        Width = 538
        Height = 163
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        ExplicitHeight = 163
        inherited Label1: TLabel
          Top = 15
          Font.Pitch = fpVariable
          ExplicitTop = 15
        end
        inherited lblMenExp: TLabel
          Top = 122
          Font.Pitch = fpVariable
          ExplicitTop = 122
        end
        inherited edtMens01: TEditFocus
          Top = 11
          Font.Pitch = fpVariable
          ExplicitTop = 11
        end
        inherited edtMens02: TEditFocus
          Top = 32
          Font.Pitch = fpVariable
          ExplicitTop = 32
        end
        inherited edtMenExp: TEditFocus
          Top = 118
          Font.Pitch = fpVariable
          ExplicitTop = 118
        end
        inherited edtMenEx2: TEditFocus
          Top = 139
          Font.Pitch = fpVariable
          ExplicitTop = 139
        end
        inherited edtMenEx3: TEditFocus
          Font.Pitch = fpVariable
        end
        inherited edtMenEx4: TEditFocus
          Font.Pitch = fpVariable
        end
        inherited edtMens03: TEditFocus
          Top = 53
          Font.Pitch = fpVariable
          ExplicitTop = 53
        end
        inherited edtMens04: TEditFocus
          Top = 74
          Font.Pitch = fpVariable
          ExplicitTop = 74
        end
        inherited edtMens05: TEditFocus
          Top = 95
          Font.Pitch = fpVariable
          ExplicitTop = 95
        end
      end
    end
  end
  inline fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame [6]
    Left = 0
    Top = 165
    Width = 542
    Height = 207
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    ExplicitTop = 165
    ExplicitWidth = 606
    ExplicitHeight = 207
    inherited pnlFundo: TPanel
      Width = 542
      Height = 207
      ExplicitWidth = 606
      ExplicitHeight = 207
      inherited pnlTransportadora: TGroupBox
        Width = 538
        Height = 205
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        ExplicitHeight = 205
        inherited pnlTransportadoraFrete: TPanel
          Width = 534
          ExplicitWidth = 598
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
            Left = 203
            Font.Pitch = fpVariable
            ExplicitLeft = 203
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
            Left = 231
            Font.Pitch = fpVariable
            OnClick = fraTransportadorabtnCalcularFreteClick
            ExplicitLeft = 231
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
            Width = 534
            ExplicitWidth = 598
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
            Width = 534
            ExplicitWidth = 598
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
          Top = 154
          Width = 534
          Font.Pitch = fpVariable
          TabOrder = 1
          ExplicitTop = 154
          ExplicitWidth = 598
        end
        inherited pnlPeso: TPanel
          Top = 177
          Width = 534
          Font.Pitch = fpVariable
          TabOrder = 2
          ExplicitTop = 177
          ExplicitWidth = 598
        end
        inherited pnlRota: TPanel
          Top = 131
          Width = 534
          TabOrder = 3
          ExplicitTop = 131
          ExplicitWidth = 598
          inherited lblRota: TLabel
            Font.Pitch = fpVariable
          end
          inherited edtCodRot: TEditFocus
            OnKeyPress = fraTransportadoraedtCodRotKeyPress
          end
        end
      end
    end
    inherited tmrHideHints: TTimer
      Left = 408
      Top = 48
    end
    inherited HintControler: TcxHintStyleController
      Left = 456
      Top = 48
    end
  end
  inline fraDescFinanBoletoAdto: TfraDescontoFinanceiroBoletoAdiantamentoFrame
    Left = 0
    Top = 372
    Width = 542
    Height = 103
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 12
    ExplicitTop = 372
    ExplicitWidth = 606
    ExplicitHeight = 103
    inherited pnlFundo: TPanel
      Width = 542
      Height = 103
      Color = 16770261
      ParentBackground = False
      ExplicitWidth = 606
      ExplicitHeight = 103
      inherited pnlDescontoFinanceiro_BoletoAdiantamento: TPanel
        Width = 542
        Color = 16770261
        ParentBackground = False
        ExplicitWidth = 606
        inherited pnlDescontoFinanceiro: TGroupBox
          Width = 254
          Font.Pitch = fpVariable
          ExplicitWidth = 254
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
          Left = 260
          Width = 234
          Font.Pitch = fpVariable
          ExplicitLeft = 260
          ExplicitWidth = 234
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
            OnClick = fraDescFinanBoletoAdtochkBolVenClick
          end
        end
      end
    end
  end
  inline fraFatorParaFaturamento: TfraFatorParaFaturamentoFrame
    Left = 0
    Top = 1088
    Width = 542
    Height = 60
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 4
    ExplicitTop = 1088
    ExplicitWidth = 606
    ExplicitHeight = 60
    inherited pnlFundo: TPanel
      Width = 542
      Height = 60
      ExplicitWidth = 606
      ExplicitHeight = 60
      inherited pnlFatorParaFaturamento: TGroupBox
        Width = 538
        Height = 60
        Font.Pitch = fpVariable
        ExplicitWidth = 602
        ExplicitHeight = 60
        inherited lblFatCal: TLabel
          Top = 16
          Font.Pitch = fpVariable
          ExplicitTop = 16
        end
        inherited lblTipoFator: TLabel
          Top = 15
          Font.Pitch = fpVariable
          ExplicitTop = 15
        end
        inherited clbTipoFator: TColorLabel
          Top = 15
          ExplicitTop = 15
        end
        inherited lblCodPor: TLabel
          Top = 40
          Font.Pitch = fpVariable
          ExplicitTop = 40
        end
        inherited edtFatCal: TEditFocus
          Top = 10
          Font.Pitch = fpVariable
          ExplicitTop = 10
        end
        inherited edtTipoFator: TEditFocus
          Top = 10
          ExplicitTop = 10
        end
        inherited edtCodPor: TEditFocus
          Top = 34
          Font.Pitch = fpVariable
          ExplicitTop = 34
        end
        inherited edtNomPor: TEditFocus
          Top = 34
          Font.Pitch = fpVariable
          ExplicitTop = 34
        end
      end
    end
  end
  inline fraLiberacaoPedido: TfraLiberacaoPedidoFrame
    Left = 0
    Top = 1148
    Width = 542
    Height = 59
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 5
    ExplicitTop = 1148
    ExplicitWidth = 606
    ExplicitHeight = 59
    inherited pnlFundo: TPanel
      Width = 542
      Height = 59
      ExplicitWidth = 606
      ExplicitHeight = 59
      inherited pnlLiberacaoPedido: TGroupBox
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
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
  inline fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame
    Left = 0
    Top = 475
    Width = 542
    Height = 229
    VertScrollBar.Range = 45
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 2
    ExplicitTop = 475
    ExplicitWidth = 606
    inherited pnlFundo: TPanel
      Width = 542
      ExplicitWidth = 606
      inherited pnlInvoice: TGroupBox
        Width = 538
        Font.Pitch = fpVariable
        ExplicitWidth = 602
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
  inline fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame
    Left = 0
    Top = 1207
    Width = 542
    Height = 27
    Align = alTop
    Color = 16770261
    ParentBackground = False
    ParentColor = False
    TabOrder = 6
    ExplicitTop = 1207
    ExplicitWidth = 606
    inherited pnlDrawBackFrame: TPanel
      Width = 542
      ExplicitWidth = 606
    end
  end
  inline fraClienteContaOrdemFrame: TfraClienteContaOrdemFrame
    Left = 0
    Top = 1234
    Width = 542
    Height = 55
    Align = alClient
    TabOrder = 7
    Visible = False
    ExplicitTop = 1234
    ExplicitWidth = 606
    ExplicitHeight = 64
    inherited pnlFundo: TPanel
      Width = 542
      Height = 55
      ExplicitWidth = 606
      ExplicitHeight = 64
      inherited pnlClienteContaOrdem: TGroupBox
        Width = 536
        ExplicitWidth = 600
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 16
  end
end
