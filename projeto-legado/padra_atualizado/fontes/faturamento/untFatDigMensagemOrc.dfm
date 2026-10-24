inherited frmFatDigMensagemOrc: TfrmFatDigMensagemOrc
  Left = 225
  Top = 262
  Width = 516
  Height = 1199
  VertScrollBar.Range = 45
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#245'es'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 516
  ExplicitHeight = 1199
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 1126
    Width = 510
    TabOrder = 4
    ExplicitTop = 1126
    ExplicitWidth = 510
    DesignSize = (
      510
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 506
      ExplicitWidth = 506
    end
    inherited btnSair: TBitBtnLocked
      Left = 289
      ExplicitLeft = 289
    end
  end
  inherited pnlStatus: TPanel
    Top = 1154
    Width = 510
    TabOrder = 3
    ExplicitTop = 1154
    ExplicitWidth = 510
    inherited pnlNomeForm: TPanel
      Left = 338
      Width = 172
      ExplicitLeft = 338
      ExplicitWidth = 172
    end
    inherited pnlInfo: TPanel
      Width = 338
      ExplicitWidth = 338
    end
  end
  inherited pgcDados: TPageControl
    Width = 510
    Height = 1126
    TabOrder = 2
    Visible = False
    ExplicitWidth = 510
    ExplicitHeight = 1126
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 502
      ExplicitHeight = 1094
    end
  end
  object pnlConfirma: TPanel [3]
    Left = 0
    Top = 1126
    Width = 510
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 1
    object btnConfirmaDados: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 102
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
    object btnCancelaDados: TBitBtnLocked
      Left = 410
      Top = 2
      Width = 98
      Height = 24
      Align = alRight
      Caption = '[Esc] Cancelar'
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
      TabOrder = 2
      OnClick = btnCancelaDadosClick
    end
    object btnMostraMargem: TBitBtnLocked
      Left = 104
      Top = 2
      Width = 103
      Height = 24
      Align = alLeft
      Caption = '[ F4 ] Margem/Lucro'
      TabOrder = 1
      OnClick = btnMostraMargemClick
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 0
    Width = 510
    Height = 1126
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    inline fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame
      Left = 2
      Top = 2
      Width = 506
      Height = 215
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 506
      inherited pnlFundo: TPanel
        Width = 506
        ExplicitWidth = 506
        ExplicitHeight = 235
        inherited pnlObservacoes: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
          ExplicitHeight = 233
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
    inline fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame
      Left = 2
      Top = 217
      Width = 506
      Height = 253
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      ExplicitLeft = 2
      ExplicitTop = 217
      ExplicitWidth = 506
      inherited pnlFundo: TPanel
        Width = 506
        ExplicitWidth = 506
        ExplicitHeight = 229
        inherited pnlTransportadora: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
          ExplicitHeight = 227
          inherited pnlTransportadoraFrete: TPanel
            Width = 498
            ExplicitWidth = 498
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
              Left = 193
              Width = 41
              Font.Pitch = fpVariable
              ExplicitLeft = 193
              ExplicitWidth = 41
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
              Left = 229
              Font.Pitch = fpVariable
              OnClick = fraTransportadorabtnCalcularFreteClick
              ExplicitLeft = 229
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
              Width = 498
              ExplicitTop = 92
              ExplicitWidth = 498
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
              Width = 498
              ExplicitTop = 69
              ExplicitWidth = 498
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
            Width = 498
            Font.Pitch = fpVariable
            ExplicitTop = 176
            ExplicitWidth = 498
          end
          inherited pnlPeso: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitTop = 199
            ExplicitWidth = 498
          end
          inherited pnlRota: TPanel
            Width = 498
            ExplicitTop = 154
            ExplicitWidth = 498
            inherited lblRota: TLabel
              Font.Pitch = fpVariable
            end
          end
        end
      end
    end
    inline fraDadosPedido: TfraDadosFechamentoPedidoFrame
      Left = 2
      Top = 699
      Width = 506
      Height = 425
      VertScrollBar.Range = 45
      Align = alClient
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 3
      ExplicitLeft = 2
      ExplicitTop = 695
      ExplicitWidth = 506
      ExplicitHeight = 429
      inherited pnlFundo: TPanel
        Width = 506
        Height = 425
        ExplicitWidth = 506
        ExplicitHeight = 429
        inherited pnlBombeamento: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
          inherited lblTotalBombeamento: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblQtdBombeamento: TLabel
            Font.Pitch = fpVariable
          end
          inherited lblPrecoBombeamento: TLabel
            Left = 220
            Font.Pitch = fpVariable
            ExplicitLeft = 220
          end
          inherited edtTotBom: TEditFocus
            Font.Pitch = fpVariable
            TabOrder = 3
          end
          inherited edtQtdBom: TEditFocus
            Font.Pitch = fpVariable
          end
          inherited edtPrcBom: TEditFocus
            Left = 253
            Font.Pitch = fpVariable
            ExplicitLeft = 253
          end
          inherited chkTaxMin: TCheckBox
            TabOrder = 0
          end
        end
        inherited pnlOutrasInformacoes: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
          inherited lblValidade: TLabel
            Font.Pitch = fpVariable
          end
          inherited chkPedExp: TCheckBox
            Top = 47
            Font.Pitch = fpVariable
            ExplicitTop = 47
          end
          inherited btnPedCmp: TBitBtnLocked
            Font.Pitch = fpVariable
          end
          inherited pnlGerPen: TPanel
            Font.Pitch = fpVariable
          end
          inherited pnlContato: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
          end
          inherited pnlTipAte: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
          end
          inherited pnlPorPed: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
          end
          inherited pnlOpcoesPV: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
          end
          inherited chkEntUrg: TCheckBox
            Top = 30
            ExplicitTop = 30
          end
          inherited chkAgrIte: TCheckBox
            Top = 13
            Width = 185
            Font.Pitch = fpVariable
            ExplicitTop = 13
            ExplicitWidth = 185
          end
          inherited pnlProjeto: TPanel
            Width = 498
            ExplicitWidth = 498
            inherited Label12: TLabel
              Font.Pitch = fpVariable
            end
          end
          inherited pnlTipOpe: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
            inherited lblTipOpe: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtTipOpe: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlCategoria: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
            inherited lblCategoria: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesCat: TEditFocus
              Font.Pitch = fpVariable
            end
          end
          inherited pnlEventos: TPanel
            Width = 498
            Font.Pitch = fpVariable
            ExplicitWidth = 498
            inherited lblEventos: TLabel
              Font.Pitch = fpVariable
            end
            inherited edtDesEvento: TEditFocus
              Font.Pitch = fpVariable
            end
          end
        end
        inherited pnlTipoDeFaturamento: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
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
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
          inherited lblFinPed: TLabel
            Height = 24
          end
          inherited pnlFinaliza: TPanel
            Width = 245
            Font.Pitch = fpVariable
            ExplicitWidth = 245
          end
        end
      end
    end
    inline fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame
      Left = 2
      Top = 470
      Width = 506
      Height = 229
      VertScrollBar.Range = 45
      Align = alTop
      Color = 16770261
      ParentBackground = False
      ParentColor = False
      TabOrder = 2
      ExplicitLeft = 2
      ExplicitTop = 466
      ExplicitWidth = 506
      inherited pnlFundo: TPanel
        Width = 506
        ExplicitWidth = 506
        inherited pnlInvoice: TGroupBox
          Width = 502
          Font.Pitch = fpVariable
          ExplicitWidth = 502
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 592
    Top = 24
  end
end
